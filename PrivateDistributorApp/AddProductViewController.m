//
//  AddProductViewController.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/22/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "AddProductViewController.h"
#import "NewProductRequestModel.h"
#import "AppDelegate.h"

@interface AddProductViewController (){
    NewProductRequestModel* _newProductRequest;
    UIImage* _image;
}
@end

@implementation AddProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];[self autoFillTextField];
    
    //Update View For FirstCompanyRegister
    [self autoFillTextField];
}

-(void)autoFillTextField{
    [[self urlText ] setText:@"http://bonduelle.org/files/_contents/4253/icon/en/mini_RU_KZ_417_Tomato_Paste3_CT2224C.jpg"];
    [[self priceText] setText:@"3.42"];
    [[self nameText] setText:@"nameText"];
    [[self brantText] setText:@"brantText"];
    [[self categoryText] setText:@"categoryText"];
    [[self madeInText] setText:@"madeInText"];
    [[self publicIdText] setText:@"publicIdText"];
    [[self nutritiveValueText] setText:@"nutritiveValueText"];
    [[self descriptionText] setText:@"descriptionText"];
    [[self storingText] setText:@"storingText"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)previewAction:(id)sender {
    if (!_newProductRequest) {
        _newProductRequest = [[NewProductRequestModel alloc]init];
    }
    
    [_newProductRequest setName:[[self nameText]text]];
    [_newProductRequest setPrice:[[self priceText]text]];
    [_newProductRequest setPublicId:[[self publicIdText]text]];
    [_newProductRequest setNutritiveValue:[[self nutritiveValueText]text]];
    [_newProductRequest setDescription:[[self descriptionText]text]];
    [_newProductRequest setStoring:[[self storingText]text]];
    [_newProductRequest setPrice:[[self priceText]text]];
    [_newProductRequest setImageUrl:[[self urlText]text]];
    [_newProductRequest setBrand:[[self brantText]text]];
    [_newProductRequest setMadeIn:[[self madeInText]text]];
    [_newProductRequest setCategory:[[self categoryText]text]];
    
    AppDelegate *appDel=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [_newProductRequest setSessionKey:appDel.logedUser.SessionKey];
    
    
    NSData* data = [_newProductRequest convertToJSONData];
    
    [self postAddProduct:data];
}

- (IBAction)imagePreview:(id)sender {
    //UIImage* img =;
    if (!_image) {
        _image= [[UIImage alloc ] init];
    }
    _image = [self getImageFromURL:[[self urlText]text]];
    [[self productImage] setImage:_image];
    
    if (!_image) {
        [[self imageStatusLabel]setText:@"Wrong url."];
    }
    else{
        [[self imageStatusLabel]setText:@"Here."];
    }
}

-(void)postAddProduct:(NSData *)jsonData{
    if (!_image) {
        _image= [[UIImage alloc ] init];
    }
    _image = [self getImageFromURL:[[self urlText]text]];
    [[self productImage] setImage:_image];
    
    if (!_image) {
        [[self imageStatusLabel]setText:@"Wrong url."];
    }
    else{
        [[self imageStatusLabel]setText:@"Here."];
    
    NSURL *url = [NSURL URLWithString:@"http://privatedistributor.apphb.com/api/products/add"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    NSString *asdas = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    NSLog(@"\n\njsonData encoding:NSUTF8StringEncoding] =>\n %@", asdas);
    
    
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
            NSLog(@"\n\nError Message =>\n %@", errorMessage);
        }
        else{
            
            
            
            
           NSString* imgName= [NSString stringWithFormat:@"product%@%@",docDir];
            [self saveImage:_image withFileName:imgName ofType:<#(NSString *)#>]
            
            
            
            /*if (!_logedUser) {
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
                    
                    [self performSegueWithIdentifier:@"registeredSegue" sender:self];
                });
            }
            else{
                NSLog(@"Undefined error, please restart the program.");
            }*/
        }
    }];
    }
}


//inDirectory:(NSString *)directoryPath
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension  {
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}

@end
