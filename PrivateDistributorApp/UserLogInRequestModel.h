//
//  UserLogInRequestModel.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/22/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLogInRequestModel : NSObject

@property (nonatomic,strong) NSString *Username;
@property (nonatomic,strong) NSString *AuthCode;

-(NSData *)convertToJSONData;

@end
