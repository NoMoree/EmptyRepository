//
//  CodeCheckViewController.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeCheckViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *CodeText;
- (IBAction)checkAuthCodeAction:(id)sender;

@end
