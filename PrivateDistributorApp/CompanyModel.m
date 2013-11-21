//
//  CompanyModel.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/21/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "CompanyModel.h"

@implementation CompanyModel

-(NSMutableDictionary *)convertToNSMutableDictionary{
    NSMutableDictionary *newData = [[NSMutableDictionary alloc]init];
    [newData setObject:[self Name] forKey:@"Name"];
    [newData setObject:[self DisplayName] forKey:@"DisplayName"];
    [newData setObject:[self Fax] forKey:@"Fax"];
    [newData setObject:[self MoreInformation] forKey:@"MoreInformation"];
    [newData setObject:[self Location] forKey:@"Location"];
    //[newData setObject:[self Type] forKey:@"Type"];
    
    //NSMutableArray *phonesArr = [[NSMutableArray alloc] init];
    //for (NSString* phone in [self Phones]) {
    //    [phonesArr addObject:phone];
    //}
    [newData setObject: [self Phones] forKey:@"Phones"];
    
    //NSMutableArray *emailsArr = [[NSMutableArray alloc] init];
    //for (NSString* mail in [self Mails]) {
    //    [emailsArr addObject:mail];
    //}
    [newData setObject: [self Mails] forKey:@"Mails"];
    
    return newData;
}

-(NSData *)convertToJSONData{
    NSMutableDictionary *newData = [[NSMutableDictionary alloc]init];
    [newData setObject:[self Name] forKey:@"Name"];
    [newData setObject:[self DisplayName] forKey:@"DisplayName"];
    [newData setObject:[self Fax] forKey:@"Fax"];
    [newData setObject:[self MoreInformation] forKey:@"MoreInformation"];
    [newData setObject:[self Location] forKey:@"Location"];
    [newData setObject:[self Type] forKey:@"Type"];
    
    //NSMutableArray *phonesArr = [[NSMutableArray alloc] init];
    //for (NSString* phone in [self Phones]) {
    //    [phonesArr addObject:phone];
    //}
    
    [newData setObject: [self Phones] forKey:@"Phones"];
    
    //NSMutableArray *emailsArr = [[NSMutableArray alloc] init];
    //for (NSString* mail in [self Mails]) {
    //    [phonesArr addObject:mail];
    //}
    [newData setObject: [self Mails] forKey:@"Mails"];
    
    
    NSData *jsonData;
    if ([NSJSONSerialization isValidJSONObject:newData]) {
        NSError* jsonError;
        jsonData = [NSJSONSerialization dataWithJSONObject:newData options:NSJSONWritingPrettyPrinted error:&jsonError];
    }
    
    return jsonData;
}
@end
