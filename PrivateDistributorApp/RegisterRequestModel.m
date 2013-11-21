//
//  RegisterRequestModel.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "RegisterRequestModel.h"
#import "CompanyModel.h"

@implementation RegisterRequestModel



-(NSData *)convertToJSONData{
    NSMutableDictionary *newData = [[NSMutableDictionary alloc]init];
    //[newData setObject:[self AuthCode] forKey:@"AuthCode"];
    [newData setObject:[self AuthCode] forKey:@"RegistrationAuthCode"];	
    [newData setObject:[self Type] forKey:@"Type"];
    [newData setObject:[self CompanyName] forKey:@"Company"];
    [newData setObject:[self AuthCode] forKey:@"AuthCode"];
    [newData setObject:[self FirstName] forKey:@"FirstName"];
    [newData setObject:[self SecondName] forKey:@"SecondName"];
    [newData setObject:[self LastName] forKey:@"LastName"];
    
    //NSMutableArray *phonesArr = [[NSMutableArray alloc] init];
    //for (NSString* phone in [self Phones]) {
    //    [phonesArr addObject:phone];
    //}
    
    [newData setObject: [self Mails] forKey:@"Mails"];
    
    //NSMutableArray *emailsArr = [[NSMutableArray alloc] init];
    //for (NSString* mail in [self Mails]) {
    //    [emailsArr addObject:mail];
    //}
    [newData setObject: [self Phones] forKey:@"Phones"];
    
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:newData]) {
        NSError* jsonError;
        jsonData = [NSJSONSerialization dataWithJSONObject:newData options:NSJSONWritingPrettyPrinted error:&jsonError];
    }
    
    return jsonData;
}

-(NSData *)convertToJSONDataWithCompany{
    NSMutableDictionary *newData = [[NSMutableDictionary alloc]init];
    [newData setObject:[self AuthCode] forKey:@"AuthCode"];
    [newData setObject:[self RegistrationAuthCode] forKey:@"RegistrationAuthCode"];
    [newData setObject:[self Type] forKey:@"Type"];
    [newData setObject:[self CompanyName] forKey:@"Company"];
    [newData setObject:[self AuthCode] forKey:@"AuthCode"];
    [newData setObject:[self FirstName] forKey:@"FirstName"];
    [newData setObject:[self SecondName] forKey:@"SecondName"];
    [newData setObject:[self LastName] forKey:@"LastName"];
    
    NSMutableArray *phonesArr = [[NSMutableArray alloc] init];
    for (NSString* phone in [self Phones]) {
        [phonesArr addObject:phone];
    }
    [newData setObject: phonesArr forKey:@"Phones"];
    
    NSMutableArray *emailsArr = [[NSMutableArray alloc] init];
    for (NSString* mail in [self Mails]) {
        [emailsArr addObject:mail];
    }
    [newData setObject: emailsArr forKey:@"Mails"];
    
    
    //with First Company for the DB
    NSMutableDictionary *companyDict = [[self Company] convertToNSMutableDictionary];
    [newData setObject: companyDict forKey:@"CompanyData"];
    
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:newData]) {
        NSError* jsonError;
        jsonData = [NSJSONSerialization dataWithJSONObject:newData options:NSJSONWritingPrettyPrinted error:&jsonError];
    }
    
    return jsonData;
}

@end
