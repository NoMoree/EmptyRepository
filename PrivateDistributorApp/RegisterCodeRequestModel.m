//
//  RegisterCodeRequestModel.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "RegisterCodeRequestModel.h"

@implementation RegisterCodeRequestModel

-(NSData *)convertToJSONData:(NSString *)authCode{
    if (authCode) {
        [self setAuthCode:authCode];
    }
    NSMutableDictionary *newCourse = [[NSMutableDictionary alloc]init];
    [newCourse setObject:[self AuthCode] forKey:@"AuthCode"];
    
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:newCourse]) {
        NSError* jsonError;
        jsonData = [NSJSONSerialization dataWithJSONObject:newCourse options:NSJSONWritingPrettyPrinted error:&jsonError];
    }
    
    return jsonData;
}
@end
