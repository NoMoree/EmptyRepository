//
//  LogInViewController.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UILabel *statusbarLabel;


- (IBAction)valueChange:(id)sender;

@property(retain) IBOutlet UIButton *someButton;

//@property (weak, nonatomic) IBOutlet UIButton *logInLabel;

-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;

- (IBAction)logInBtnInside:(id)sender;

//@property (weak, nonatomic) IBOutlet UIButton *logInBtn;

- (IBAction)logInAction:(id)sender;

- (IBAction)unwindToMain:(UIStoryboardSegue *) segue;
@end