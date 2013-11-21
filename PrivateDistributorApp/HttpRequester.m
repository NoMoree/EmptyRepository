//
//  HttpRequester.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "HttpRequester.h"

@implementation HttpRequester

-(void)postJSONCourse:(NSData *)jsonData{
    

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
        
        
        if (!error) {
            //dispatch_async(dispatch_get_main_queue(), ^{
                
                //[self checkLogin];
                //[[self tableView] reloadData];
            //});
        }
        	
        //return json;
        
        //Models *responseCourse = [[Models alloc] init];
        
        //[responseCourse setAuthCode:[json objectForKey:@"AuthCode"]];
        
        
        
        
        //return (NSObject *)responseCourse;
        //Do anything you want with it
        
        
        // NSString* nasf = [response description];
        //NSInteger* asd = 353;
        //Models *newCours11e = [[Models alloc] init];
        
        
        //[responseText rel];
    }];
}


@end
