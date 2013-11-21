//
//  RegisterViewController.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "RegisterViewController.h"

#import "RegisterCodeRequestModel.h"
#import "RegisterRequestModel.h"

@interface RegisterViewController (){
    RegisterRequestModel *_registerRequest;
}
//- (void)setUserInfo;
@end


@implementation RegisterViewController
- (void)setUserInfo:(id)newUserInfo
{
    if (!_registerRequest) {
        _registerRequest = [[RegisterRequestModel alloc] init];
        
        // Update the view.
        //[self configureView];
    }
    
    _registerRequest = newUserInfo;
}

- (void)configureView
{
    if (_registerRequest) {
        self.emailText.text = [_registerRequest Email];
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

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


- (IBAction)confirmAction:(id)sender {
    if (!_registerRequest) {
        _registerRequest = [[RegisterRequestModel alloc] init];
    }
    if (!_registerRequest.Email) {
        _registerRequest.Email = [[self emailText ]text];
    }
    if (!_registerRequest.Company) {
        _registerRequest.Company = [[CompanyModel alloc] init];
    }
    _registerRequest.Company.Name=  [[self companyNameText ]text];
    _registerRequest.Company.DisplayName=  [[self companyNameText ]text];
    _registerRequest.Company.MoreInformation=  [[self companyNameText ]text];
    _registerRequest.Company.Location=  [[self companyNameText ]text];
    
    
    //email validation and adding
    NSMutableArray* newMails =[[NSMutableArray alloc] init];
    //if (!_registerRequest.Mails) {
    //    _registerRequest.Mails = [[NSMutableArray alloc] init];
    //}
    //if (_registerRequest.Company.Mails.count >0) {
    //        [_registerRequest.Company.Mails removeAllObjects];
    //}
    NSString* elementToAdd =[[self companyEmailText1 ]text];
    if ([self emailValidation:elementToAdd]) {
        //[_registerRequest.Company.Mails addObject:elementToAdd] ;
        [newMails addObject:elementToAdd];
    }
    elementToAdd =[[self companyEmailText2 ]text];
    if ([self emailValidation:elementToAdd]) {
        //[_registerRequest.Company.Mails addObject:elementToAdd] ;
        [newMails addObject:elementToAdd];
    }
    elementToAdd =[[self companyEmailText3 ]text];
    if ([self emailValidation:elementToAdd]) {
        //[_registerRequest.Company.Mails addObject:elementToAdd] ;
        [newMails addObject:elementToAdd];
    }
    [[_registerRequest Company] setMails:newMails];
    
    //phone validation and adding
    NSMutableArray* newPhones =[[NSMutableArray alloc] init];
    //if (!_registerRequest.Phones) {
    //    _registerRequest.Phones = [[NSMutableArray alloc] init];
    //}
    //if (_registerRequest.Company.Phones.count >0) {
    //    [_registerRequest.Company.Phones removeAllObjects];
    //}
    elementToAdd =[[self companyPhoneText1 ]text];
    if (elementToAdd.length >4) {
        //[_registerRequest.Company.Phones addObject:elementToAdd] ;
        [newPhones addObject:elementToAdd];
    }
    elementToAdd =[[self companyPhoneText2 ]text];
    if (elementToAdd.length >4) {
        //[_registerRequest.Company.Phones addObject:elementToAdd] ;
        [newPhones addObject:elementToAdd];
    }
    elementToAdd =[[self companyPhoneText3 ]text];
    if (elementToAdd.length >4) {
        //[_registerRequest.Company.Phones addObject:elementToAdd] ;
        [newPhones addObject:elementToAdd];
    }
    [[_registerRequest Company] setPhones:newPhones];
    
    //fax
    elementToAdd =[[self companyFaxText ]text];
    if (elementToAdd.length >4) {
        _registerRequest.Company.Fax = elementToAdd;
    }
    //Promp errors before cont
    _registerRequest.CompanyName = @"Administrator";
    if ([_registerRequest.CompanyName isEqualToString:@"Administrator"]) {
        [self performSegueWithIdentifier:@"regiserUserSegue" sender:self];
    }
    else{
        //performe POST
    }
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"regiserUserSegue"]) {
        [[segue destinationViewController] setUserInfo:_registerRequest];
    }
}
//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self.tableView endEditing:YES];
//    [super touchesBegan:touches withEvent:event];
//}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [[self.tableView superView] endEditing];
//}

//- (IBAction)insertNewEmail:(id)sender {
//    if (!_emails) {
 //       _emails = [[NSMutableArray alloc] init];
 //   }
 //   //NSString* str =[self emailText];
 //   //NSObject* email =[self emailText.NSObject];
 //   //[_emails addObject:[self emailText]];
 //  [_emails insertObject:[NSDate date] atIndex:0];
 //   NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
 //   [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}
@end
