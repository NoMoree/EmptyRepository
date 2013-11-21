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
    
    //Update View For FirstCompanyRegister
    [self configureView];
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
        //printf("secret = %s\n", [[cipher description] UTF8String]);
        
        //plain = [cipher AES256DecryptWithKey:key];
        //printf("plain = %s\n", [[plain description] UTF8String]);
        //printf("plain-back =>%s\n", [[[NSString alloc] initWithData:plain encoding:NSUTF8StringEncoding] UTF8String]);
        
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
    
    //NSData* testData = @"{ \"Mails\" : [ \"uuu1@abv.bg\", \"uuu2@abv.bg\", \"uuu3@abv.bg\" ], \"SecondName\" : \"SecondName\", \"RegistrationAuthCode\" : \"0sSTHAeLXVdQZqFEgRSlLNaBhYYPKBmYMbylkBRVaTDWywhdxc\", \"Type\" : \"Administrator\", \"Company\" : \"Administrator\", \"FirstName\" : \"FirstName\", \"Phones\" : [ \"phone1U\", \"phone2U\", \"phone3U\" ], \"LastName\" : \"LastName\", \"CompanyData\" : { \"Mails\" : [ \"ccccc1@abv.bg\", \"ccccc2@abv.bg\", \"ccccc3@abv.bg\" ], \"Location\" : \"CompanyName\", \"MoreInformation\" : \"CompanyName\", \"Phones\" : [ \"phone1C\", \"phone2C\", \"phone3C\" ], \"Name\" : \"CompanyName\", \"Fax\" : \"faxxxxxx\", \"DisplayName\" : \"CompanyName\" } }";
    [request setHTTPBody:jsonData];
    //[request setHTTPBody:testData];
    
    //NSString *asdas = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    //NSLog(@"\n\njsonData encoding:NSUTF8StringEncoding] =>\n %@", asdas);
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^ (NSURLResponse *response, NSData *data, NSError *error){
        
        if (error) {
            NSLog(@"\n\nAn error =>\n %@", error);
        }
        
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
            UserLoged* logedUser = [[UserLoged alloc] init];
            [logedUser convertToUserLoged:json];
            
            if (logedUser.SessionKey) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!_logedUser) {
                        _logedUser = [[UserLoged alloc] init];
                    }
                    _logedUser = logedUser;
                    
                    //if ([registerRequest.CompanyName isEqualToString:@"Administrator"]) {
                    //    [self performSegueWithIdentifier:@"firstCompanyRegisterSegue" sender:self];
                    //}
                    //else{
                    //    [self performSegueWithIdentifier:@"registrationSegue" sender:self];
                    //}

                    
                    
                    
                    //if (!_registerRequest) {
                    //    _registerRequest = [[RegisterRequestModel alloc] init];
                    //}
                    //_registerRequest = registerRequest;
                    
                    //if ([registerRequest.CompanyName isEqualToString:@"Administrator"]) {
                        [self performSegueWithIdentifier:@"registeredSegue" sender:self];
                    //}
                    //else{
                    //    [self performSegueWithIdentifier:@"registrationSegue" sender:self];
                    //}
                });
            }
            else{
                NSLog(@"Undefined error, please restart the program.");
            }
        }

        
        //if (!error) {
        //    dispatch_async(dispatch_get_main_queue(), ^{
                //if (!_registerRequest) {
                //    _registerRequest = [[RegisterRequestModel alloc] init];
                //}
                //_registerRequest = registerRequest;
                
                //if ([registerRequest.CompanyName isEqualToString:@"Administrator"]) {
                //    [self performSegueWithIdentifier:@"firstCompanyRegisterSegue" sender:self];
                //}
                //else{
                //    [self performSegueWithIdentifier:@"registrationSegue" sender:self];
                //}
                
                
                //[self checkLogin];
                //[[self tableView] reloadData];
        //    });
        //}
        //Models *responseCourse = [[Models alloc] init];
        
        //[responseCourse setAuthCode:[json objectForKey:@"AuthCode"]];
        
        
        
        //return (NSObject *)responseCourse;
        //Do anything you want with it
        
        
        // NSString* nasf = [response description];
        //NSInteger* asd = 353;
        //Models *newCours11e = [[Models alloc] init];
        
        
        //[responseText rel];
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"registeredSegue"]) {
        //[[segue destinationViewController] setUserInfo:_logedUser];
    }
}
@end
