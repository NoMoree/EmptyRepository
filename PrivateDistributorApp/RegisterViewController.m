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
    
    //testing
    [self autoFillTextField];
    
    //Update View For FirstCompanyRegister
    [self configureView];
}

-(void)autoFillTextField{
    [[self emailText] setText:@"i9q19@abv.bg"];
    [[self companyNameText ] setText:@"CompanyName!"];
    [[self companyEmailText1] setText:@"CompMail1@abv.bg"];
    [[self companyEmailText2] setText:@"CompMail2@abv.bg"];
    [[self companyEmailText3] setText:@"CompMail3@abv.bg"];
    [[self companyPhoneText1] setText:@"CompanyPhone1"];
    [[self companyPhoneText2] setText:@"CompanyPhone2"];
    [[self companyPhoneText3] setText:@"CompanyPhone3"];
    [[self companyFaxText] setText:@"CompanyFax"];
    [[self companyAddressText] setText:@"Address"];
    [[self companyMoreInfoText] setText:@"MoreInformation"];
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
    _registerRequest.Company.MoreInformation=  [[self companyMoreInfoText ]text];
    _registerRequest.Company.Location=  [[self companyAddressText ]text];
    
    
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
    
    elementToAdd =[[self companyPhoneText1 ]text];
    if (elementToAdd.length >4) {
        [newPhones addObject:elementToAdd];
    }
    elementToAdd =[[self companyPhoneText2 ]text];
    if (elementToAdd.length >4) {
        [newPhones addObject:elementToAdd];
    }
    elementToAdd =[[self companyPhoneText3 ]text];
    if (elementToAdd.length >4) {
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
@end
