//
//  LogInViewController.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"

#import <CommonCrypto/CommonCryptor.h>
#import "AES256.h"

#import "CodeCheckViewController.h"
#import "HttpRequester.h"
#import "UserLoged.h"
#import "UserLogInRequestModel.h"

@interface LogInViewController (){
    UserLogInRequestModel *_logInReques;
    UserLoged *_logedUser;
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
    //if (_logedUser) {
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
    //}
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
    
    [[self statusbarLabel] setText:@""];
    
    [_someButton setTitle: @"myTitle" forState: UIControlStateNormal];
    
    
    
    [[self usernameText] setText:@"i9q19@abv.bg"];
    [[self passwordText] setText:@"password"];
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

- (IBAction)logInAction:(id)sender {
    if (!_logInReques) {
        _logInReques = [[UserLogInRequestModel alloc] init];
    }
    [_logInReques setUsername:[[self usernameText] text]];
    
    @autoreleasepool {
        NSString *key = @"64459003-1a63-4b3b-b649-ffab8433806b";
        NSString *secret = self.passwordText.text;
        
        NSData *plain = [secret dataUsingEncoding:NSUTF8StringEncoding];
        NSData *cipher = [plain AES256EncryptWithKey:key];
        [_logInReques setAuthCode:[cipher description]];
    }
    
    NSData* data = [_logInReques convertToJSONData];
    
    //POST
    [self postUserLogin:data];
    //[self performSegueWithIdentifier:@"logInSegue" sender:self];
}

-(void)postUserLogin:(NSData *)jsonData{
    NSURL *url = [NSURL URLWithString:@"http://privatedistributor.apphb.com/api/users/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^ (NSURLResponse *response, NSData *data, NSError *error){
        NSString* responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (data) {
            NSLog(@"\n\nAn data =>\n  %@", responseText);
        }
        
        if (response) {
            NSLog(@"\n\nAn response description =>\n %@", [response description]);
        }
        
        NSError* jsonError;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        NSString* errorMessage =[json objectForKey:@"Message"];
        if (errorMessage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self statusbarLabel] setText:errorMessage];
                NSLog(@"\n\nError Message =>\n %@", errorMessage);
            });
        }
        else{
            if (!_logedUser) {
                _logedUser = [[UserLoged alloc] init];
            }
            
            [_logedUser convertToUserLoged:json];
            
            if (_logedUser.SessionKey) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    AppDelegate *appDel=(AppDelegate*)[UIApplication sharedApplication].delegate;
                    
                    if (!appDel.logedUser) {
                        appDel.logedUser = [[UserLoged alloc]init];
                    }
                    appDel.logedUser = _logedUser;
                    
                    [self performSegueWithIdentifier:@"logInSegue" sender:self];
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[self statusbarLabel] setText:@"Undefined error, please restart the program."];
                    NSLog(@"\n\nError Message =>\n %@", @"Undefined error, please restart the program.");
                });
            }
        }
    }];
}

- (IBAction)unwindToMain:(UIStoryboardSegue *) segue{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self view]endEditing:TRUE];
}

@end
