//
//  UserLoged.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/21/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyModel.h"

@interface UserLoged : NSObject

@property (nonatomic,strong) NSString *Username;
@property (nonatomic,strong) NSString *Type;
@property (nonatomic,strong) NSString *SessionKey;
@property (nonatomic,strong) NSString *FirstName;
@property (nonatomic,strong) NSString *SecondName;
@property (nonatomic,strong) NSString *LastName;
@property (nonatomic,strong) NSMutableArray *Mails;
@property (nonatomic,strong) NSMutableArray *Phones;

@property (nonatomic,strong) CompanyModel *Company;


-(void)convertToUserLoged:(NSDictionary *)data;
@end
