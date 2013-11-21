//
//  LogInViewController.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "LogInViewController.h"


#import "CodeCheckViewController.h"
#import "HttpRequester.h"
#import "UserLoged.h"

@interface LogInViewController (){
    UserLoged* _logedUser;
}
//- (void)setUserInfo;
@end

@implementation LogInViewController
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
    
    
    [_someButton setTitle: @"myTitle" forState: UIControlStateNormal];
    //[_someButton setValue:@"myTitle" forKey:@"edqwe"];
}

-(void) viewDidAppear:(BOOL)animated
{
    //self.logInLabel.titleLabel  = @"asdas";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 //   NSInteger asdas = 32523;
   // NSInteger asdasfas = 32523;
}

- (IBAction)logInBtnInside:(id)sender {
}

- (IBAction)valueChange:(id)sender{
    NSInteger asd = 3;
    
    
    NSInteger a34sd = 3+asd;
    
    asd =a34sd+2;
}



- (IBAction)logInAction:(id)sender {
    
    [self performSegueWithIdentifier:@"logInSegue" sender:self];
    
    //[self performSegueWithIdentifier:@"masterSegue" sender:self];
    
    
}

- (IBAction)unwindToMain:(UIStoryboardSegue *) segue{
    
}

- (void)checkLogin{
    [self performSegueWithIdentifier:@"loggedIn" sender:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self view]endEditing:TRUE];
}

@end
