//
//  UserLogInRequestModel.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/22/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "UserLogInRequestModel.h"

@implementation UserLogInRequestModel

-(NSData *)convertToJSONData{
    NSMutableDictionary *newCourse = [[NSMutableDictionary alloc]init];;
    [newCourse setObject:[self Username] forKey:@"Username"];
    [newCourse setObject:[self AuthCode] forKey:@"AuthCode"];
    
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:newCourse]) {
        NSError* jsonError;
        jsonData = [NSJSONSerialization dataWithJSONObject:newCourse options:NSJSONWritingPrettyPrinted error:&jsonError];
    }
    
    return jsonData;
}

@end
