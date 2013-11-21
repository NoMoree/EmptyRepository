//
//  CompanyModel.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/21/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

@property (nonatomic) NSInteger *Id;
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,strong) NSString *DisplayName;
@property (nonatomic,strong) NSString *Fax;
@property (nonatomic,strong) NSString *MoreInformation;
@property (nonatomic,strong) NSString *Location;
@property (nonatomic,strong) NSMutableArray *Mails;
@property (nonatomic,strong) NSMutableArray *Phones;
@property (nonatomic,strong) NSEnumerator *Type;

-(NSData *)convertToJSONData;

-(NSMutableDictionary *)convertToNSMutableDictionary;

@end