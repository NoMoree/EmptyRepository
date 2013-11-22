//
//  RegisterUserViewController.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/21/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "RegisterUserViewController.h"

#import "RegisterRequestModel.h"
#import <CommonCrypto/CommonCryptor.h>
#import "AES256.h"
#import "UserLoged.h"
#import "AppDelegate.h"

@interface RegisterUserViewController (){
    RegisterRequestModel *_registerRequest;
    UserLoged* _logedUser;
}
//- (void)setUserInfo;
@end

@implementation RegisterUserViewController
- (void)setUserInfo:(id)newUserInfo
{
    if (!_registerRequest) {
        _registerRequest = [[RegisterRequestModel alloc] init];
    }
    
    _registerRequest = newUserInfo;
    
    [self configureView];
}

- (void)configureView
{
    if (_registerRequest) {
        self.emailLabel.text = [_registerRequest Email];
        if ([[_registerRequest CompanyName] isEqualToString:@"Administrator"]) {
            self.companyLabel.text = [[_registerRequest Company] Name];
            self.userTypeLabel.text = @"Owner account";
        }
        else{
            self.companyLabel.text = [_registerRequest CompanyName];
            if (![_registerRequest Type]) {
                self.userTypeLabel.text = @"EROOR no TYPE";
            }
            self.userTypeLabel.text = [_registerRequest Type];;
        }
    }
}

-(BOOL) emailValidation:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL myStringMatchesRegEx=[emailTest evaluateWithObject:email];
    
    return myStringMatchesRegEx;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //test
    [self autoFillTextField];
    
    //Update View For FirstCompanyRegister
    [self configureView];
}

-(void)autoFillTextField{
    [[self passwordText] setText:@"password"];
    [[self firstNameText ] setText:@"firstNameText"];
    [[self secondNameText] setText:@"secondNameText"];
    [[self lastNameText] setText:@"lastNameText"];
    [[self EmailText1] setText:@"user1@abv.bg"];
    [[self EmailText2] setText:@"user2@abv.bg"];
    [[self EmailText3] setText:@"user3@abv.bg"];
    [[self PhoneText1] setText:@"UserPhone1"];
    [[self PhoneText2] setText:@"UserPhone2"];
    [[self PhoneText3] setText:@"UserPhone3"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (IBAction)confirmAction:(id)sender {
    if (!_registerRequest) {
        _registerRequest = [[RegisterRequestModel alloc] init];
    }
    if (!_registerRequest.Email) {
        _registerRequest.Email = [[self emailLabel ]text];
    }
    _registerRequest.FirstName=  [[self firstNameText ]text];
    _registerRequest.SecondName=  [[self secondNameText ]text];
    _registerRequest.LastName=  [[self lastNameText ]text];
    
    @autoreleasepool {
        NSString *key = @"64459003-1a63-4b3b-b649-ffab8433806b";
        NSString *secret = self.passwordText.text;
        
        NSData *plain = [secret dataUsingEncoding:NSUTF8StringEncoding];
        NSData *cipher = [plain AES256EncryptWithKey:key];
        [_registerRequest setAuthCode:[cipher description]];
    }
    
    //email validation and adding
    if (!_registerRequest.Mails) {
        _registerRequest.Mails = [[NSMutableArray alloc] init];
    }
    if (_registerRequest.Mails.count >0) {
        [_registerRequest.Mails removeAllObjects];
    }
    NSString* elementToAdd =[[self EmailText1 ]text];
    if ([self emailValidation:elementToAdd]) {
        [_registerRequest.Mails addObject:elementToAdd] ;
    }
    elementToAdd =[[self EmailText2 ]text];
    if ([self emailValidation:elementToAdd]) {
        [_registerRequest.Mails addObject:elementToAdd] ;
    }
    elementToAdd =[[self EmailText3 ]text];
    if ([self emailValidation:elementToAdd]) {
        [_registerRequest.Mails addObject:elementToAdd];
    }
    
    //phone validation and adding
    if (!_registerRequest.Phones) {
        _registerRequest.Phones = [[NSMutableArray alloc] init];
    }
    if (_registerRequest.Phones.count >0) {
        [_registerRequest.Phones removeAllObjects];
    }
    elementToAdd =[[self PhoneText1 ]text];
    if (elementToAdd.length >4) {
        [_registerRequest.Phones addObject:elementToAdd] ;
    }
    elementToAdd =[[self PhoneText2 ]text];
    if (elementToAdd.length >4) {
        [_registerRequest.Phones addObject:elementToAdd] ;
    }
    elementToAdd =[[self PhoneText3 ]text];
    if (elementToAdd.length >4) {
        [_registerRequest.Phones addObject:elementToAdd] ;
    }
    
    //Promp errors before cont
    if ([_registerRequest.CompanyName isEqualToString:@"Administrator"]) {
        NSData* dataWithCompany = [_registerRequest convertToJSONDataWithCompany];
        
        NSString *asdas = [[NSString alloc] initWithData:dataWithCompany encoding:NSUTF8StringEncoding];
        NSLog(@"\n\njsonData encoding:NSUTF8StringEncoding] =>\n %@", asdas);
        
        [self postUserRegister:dataWithCompany];
    }
    else{
        NSData* data = [_registerRequest convertToJSONData];
    }
    
}


-(void)postUserRegister:(NSData *)jsonData{
    NSURL *url = [NSURL URLWithString:@"http://privatedistributor.apphb.com/api/users/register"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    //NSString *asdas = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    //NSLog(@"\n\njsonData encoding:NSUTF8StringEncoding] =>\n %@", asdas);
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^ (NSURLResponse *response, NSData *data, NSError *error){
        NSString* responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (data) {
            NSLog(@"\n\nAn data =>\n  %@", responseText);
        }
        
        if (response) {
            NSLog(@"\n\nAn response description =>\n %@", [response description]);
        }
        
        NSError* jsonError;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        NSString* errorMessage =[json objectForKey:@"Message"];
        if (errorMessage) {
            NSLog(@"\n\nError Message =>\n %@", errorMessage);
        }
        else{
            if (!_logedUser) {
                _logedUser = [[UserLoged alloc] init];
            }
            
            [_logedUser convertToUserLoged:json];
            
            if (_logedUser.SessionKey) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    AppDelegate *appDel=(AppDelegate*)[UIApplication sharedApplication].delegate;
                    
                    if (!appDel.logedUser) {
                        appDel.logedUser = [[UserLoged alloc]init];
                    }
                    appDel.logedUser = _logedUser;
                    
                    [self performSegueWithIdentifier:@"registeredSegue" sender:self];
                });
            }
            else{
                NSLog(@"Undefined error, please restart the program.");
            }
        }
    }];
}
@end
