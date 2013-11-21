//
//  RegisterCodeRequestModel.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterCodeRequestModel : NSObject

@property (nonatomic,strong) NSString *AuthCode;

-(NSData *)convertToJSONData:(NSString *)authCode;
@end
