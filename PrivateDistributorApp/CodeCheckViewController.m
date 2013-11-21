//
//  CodeCheckViewController.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "CodeCheckViewController.h"
#import "FirstCompanyViewController.h"

#import "RegisterCodeRequestModel.h"
#import "RegisterRequestModel.h"

@interface CodeCheckViewController (){
    RegisterRequestModel *_registerRequest;
    RegisterCodeRequestModel *_codeRequest;
}
@end

@implementation CodeCheckViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) emailValidation:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL myStringMatchesRegEx=[emailTest evaluateWithObject:email];
    
    return myStringMatchesRegEx;
}

- (IBAction)checkAuthCodeAction:(id)sender {
    NSString* authCode = self.CodeText.text;
    //NSString* authCode = @"rrrr@abv.bg";
    
    //[self performSegueWithIdentifier:@"testing" sender:self];
    if (authCode && (authCode.length == 50 ||[self emailValidation:authCode])) {
        if (!_codeRequest) {
            _codeRequest = [[RegisterCodeRequestModel alloc] init];
        }
        NSData* request = [_codeRequest convertToJSONData:authCode];
        
        [self postRegisterCode:request];
    }
    else{
        NSLog(@"\n\nError Message =>\n %@", @"The registration code is incorect!");
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"firstCompanyRegisterSegue"]) {
        //_registerRequest
        
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        if (!_registerRequest.Mails) {
            _registerRequest.Mails=[[NSMutableArray alloc] init];
        }
        if (!_registerRequest.Phones) {
            _registerRequest.Phones=[[NSMutableArray alloc] init];
        }
        [[segue destinationViewController] setUserInfo:_registerRequest];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self view]endEditing:TRUE];
}


-(void)postRegisterCode:(NSData *)jsonData{
    NSURL *url = [NSURL URLWithString:@"http://privatedistributor.apphb.com/api/NewUserAuthCodeCheck/NewUserAuthCodeCheck"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:jsonData];
    
    
    NSString *asdas = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    NSLog(@"\n\njsonData encoding:NSUTF8StringEncoding] =>\n %@", asdas);
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^ (NSURLResponse *response, NSData *data, NSError *error){
        
        if (error) {
            NSLog(@"\n\nAn error =>\n %@", error);
        }
        
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
            NSLog(@"\n\nError Message =>\n %@", errorMessage);
        }
        else{
            RegisterRequestModel *registerRequest = [[RegisterRequestModel alloc] init];
            
            [registerRequest setRegistrationAuthCode:[json objectForKey:@"AuthCode"]];
            [registerRequest setEmail:[json objectForKey:@"Email"]];
            [registerRequest setType:[json objectForKey:@"Type"]];
            [registerRequest setCompanyName:[json objectForKey:@"Company"]];
            
            if (registerRequest.RegistrationAuthCode) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!_registerRequest) {
                        _registerRequest = [[RegisterRequestModel alloc] init];
                    }
                    _registerRequest = registerRequest;
                    
                    if ([registerRequest.CompanyName isEqualToString:@"Administrator"]) {
                        [self performSegueWithIdentifier:@"firstCompanyRegisterSegue" sender:self];
                    }
                    else{
                        [self performSegueWithIdentifier:@"registrationSegue" sender:self];
                    }
                    //[self checkLogin];
                    //[[self tableView] reloadData];
                });
            }
            else{
                NSLog(@"Undefined error, please restart the program.");
            }
        }
    }];
}

@end
