//
//  NewProductRequestModel.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/22/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "NewProductRequestModel.h"

@implementation NewProductRequestModel

-(NSData *)convertToJSONData{
    NSMutableDictionary *newCourse = [[NSMutableDictionary alloc]init];
    
    [newCourse setObject:[self SessionKey] forKey:@"SessionKey"];
    [newCourse setObject:[self PublicId] forKey:@"PublicId"];
    [newCourse setObject:[self Name] forKey:@"Name"];
    [newCourse setObject:[self NutritiveValue] forKey:@"NutritiveValue"];
    [newCourse setObject:[self Description] forKey:@"Description"];
    [newCourse setObject:[self Storing] forKey:@"Storing"];
    [newCourse setObject:[self Price] forKey:@"Price"];
    [newCourse setObject:[self ImageUrl] forKey:@"ImageUrl"];
    [newCourse setObject:[self Brand] forKey:@"Brand"];
    [newCourse setObject:[self MadeIn] forKey:@"MadeIn"];
    [newCourse setObject:[self Category] forKey:@"Category"];
    
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:newCourse]) {
        NSError* jsonError;
        jsonData = [NSJSONSerialization dataWithJSONObject:newCourse options:NSJSONWritingPrettyPrinted error:&jsonError];
    }
    
    return jsonData;
}

-(Product *)convertToUserLoged:(NSDictionary *)data{
    Product* product = [[Product alloc]init];
    
    NSInteger* gjhgh =[data objectForKey:@"Id"];
    [product setId:[data objectForKey:@"Id"]];
    [product setImageType:[data objectForKey:@"ImageType"]];
    [product setPublicId:[data objectForKey:@"PublicId"]];
    [product setName:[data objectForKey:@"Name"]];
    [product setNutritiveValue:[data objectForKey:@"NutritiveValue"]];
    [product setDescription:[data objectForKey:@"Description"]];
    [product setStoring:[data objectForKey:@"Storing"]];
    [product setPrice:[data objectForKey:@"Price"]];
    [product setImageUrl:[data objectForKey:@"ImageUrl"]];
    [product setBrand:[data objectForKey:@"Brand"]];
    [product setMadeIn:[data objectForKey:@"MadeIn"]];
    [product setCategory:[data objectForKey:@"Category"]];
    
}
@end
