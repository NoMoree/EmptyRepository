//
//  RegisterUserViewController.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/21/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterUserViewController : UITableViewController

@property (strong, nonatomic) id userDetail;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UITextField *firstNameText;
@property (weak, nonatomic) IBOutlet UITextField *secondNameText;
@property (weak, nonatomic) IBOutlet UITextField *lastNameText;

@property (weak, nonatomic) IBOutlet UITextField *EmailText1;
@property (weak, nonatomic) IBOutlet UITextField *EmailText2;
@property (weak, nonatomic) IBOutlet UITextField *EmailText3;

@property (weak, nonatomic) IBOutlet UITextField *PhoneText1;
@property (weak, nonatomic) IBOutlet UITextField *PhoneText2;
@property (weak, nonatomic) IBOutlet UITextField *PhoneText3;

- (IBAction)confirmAction:(id)sender;
@end
