//
//  RegisterViewController.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UITableViewController

@property (strong, nonatomic) id userDetail;

@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *companyNameText;
@property (weak, nonatomic) IBOutlet UITextField *companyEmailText1;
@property (weak, nonatomic) IBOutlet UITextField *companyEmailText2;
@property (weak, nonatomic) IBOutlet UITextField *companyEmailText3;
@property (weak, nonatomic) IBOutlet UITextField *companyPhoneText1;
@property (weak, nonatomic) IBOutlet UITextField *companyPhoneText2;
@property (weak, nonatomic) IBOutlet UITextField *companyPhoneText3;
@property (weak, nonatomic) IBOutlet UITextField *companyFaxText;
@property (weak, nonatomic) IBOutlet UITextField *companyAddressText;
@property (weak, nonatomic) IBOutlet UITextView  *companyMoreInfoText;

- (IBAction)confirmAction:(id)sender;

@end
