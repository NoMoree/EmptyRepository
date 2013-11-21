//
//  RegisterRequestModel.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/20/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyModel.h"

@interface RegisterRequestModel : NSObject

@property (nonatomic,strong) NSString *Email;
@property (nonatomic,strong) NSString *RegistrationAuthCode;
@property (nonatomic,strong) NSString *Type;
@property (nonatomic,strong) NSString *CompanyName;
@property (nonatomic,strong) NSString *AuthCode;
@property (nonatomic,strong) NSString *FirstName;
@property (nonatomic,strong) NSString *SecondName;
@property (nonatomic,strong) NSString *LastName;
@property (nonatomic,strong) NSMutableArray *Mails;
@property (nonatomic,strong) NSMutableArray *Phones;

@property (nonatomic,strong) CompanyModel *Company;

//userType

-(NSData *)convertToJSONData;
-(NSData *)convertToJSONDataWithCompany;
/*{
    "SessionKey": "1clNCxXOzWZTevRcaBVwbxRuGJqWBeItVNoEEANcdQSGDFhtYE",
 
    "FirstName ": "MainFirst",
    "SecondName": "MainSecond",
    "LastName  ": "MainLast",
    "Mails
    "Phones     ": [
               "sample string 1",
               "sample string 2",
               "sample string 3"
               ],
    "UserType    ": 0
}*/
@end
