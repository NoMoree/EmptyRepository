//
//  tessssstViewController.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/21/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "tessssstViewController.h"
#import "UserLoged.h"

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
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
