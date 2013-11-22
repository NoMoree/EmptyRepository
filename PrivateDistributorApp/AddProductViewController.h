//
//  AddProductViewController.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/22/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProductViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UITextField *urlText;

@property (weak, nonatomic) IBOutlet UITextField *priceText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *brantText;
@property (weak, nonatomic) IBOutlet UITextField *categoryText;
@property (weak, nonatomic) IBOutlet UITextField *madeInText;
@property (weak, nonatomic) IBOutlet UITextField *publicIdText;

@property (weak, nonatomic) IBOutlet UITextView *nutritiveValueText;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UITextView *storingText;

- (IBAction)previewAction:(id)sender;
- (IBAction)imagePreview:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *imageStatusLabel;

@end
