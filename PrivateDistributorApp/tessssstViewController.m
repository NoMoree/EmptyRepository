//
//  tessssstViewController.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/21/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "tessssstViewController.h"
#import "UserLoged.h"
#import "AppDelegate.h"

@interface tessssstViewController (){
    UserLoged* _logedUser;
}
//- (void)setUserInfo;
@end

@implementation tessssstViewController
- (void)setUserInfo:(id)newUserInfo
{
    if (!_logedUser) {
        _logedUser = [[UserLoged alloc] init];
    }
    
    _logedUser = newUserInfo;
    
    [self configureView];
}

- (void)configureView
{
    if (_logedUser) {
        //self.emailLabel.text = [_registerRequest Email];
        //if ([[_logedUser CompanyName] isEqualToString:@"Administrator"]) {
            //    self.companyLabel.text = [[_logedUser Company] Name];
            //    self.userTypeLabel.text = @"Owner account";
        //}
        //else{
            //self.companyLabel.text = [_registerRequest CompanyName];
            //if (![_logedUser Type]) {
            //    self.userTypeLabel.text = @"EROOR no TYPE";
            //}
            //self.userTypeLabel.text = [_registerRequest Type];;
        //}
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AppDelegate *appDel=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSLog(@"username: %@",appDel.logedUser.Username);;//this sn correct!
    NSLog(@"SessionKey: %@",appDel.logedUser.SessionKey);;//this sn correct!
    NSLog(@"Company: %@",appDel.logedUser.Company);;//this sn correct!
    //NSLog(@"1st phone: %@",appDel.logedUser.Phones[1]);;//this sn correct!

    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
