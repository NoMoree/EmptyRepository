//
//  NewProductRequestModel.h
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/22/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
@interface NewProductRequestModel : NSObject


//@property (assign) NSInteger *Id;
//@property (nonatomic,strong) NSString *ImageType;

@property (nonatomic,strong) NSString *SessionKey;
@property (nonatomic,strong) NSString *PublicId;
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,strong) NSString *NutritiveValue;
@property (nonatomic,strong) NSString *Description;
@property (nonatomic,strong) NSString *Storing;
@property (nonatomic,strong) NSString *Price;
@property (nonatomic,strong) NSString *ImageUrl;
@property (nonatomic,strong) NSString *Brand;
@property (nonatomic,strong) NSString *MadeIn;
@property (nonatomic,strong) NSString *Category;

-(NSData *)convertToJSONData;

-(Product *)convertToProduct:(NSDictionary *)data;
@end
