//
//  UserLoged.m
//  PrivateDistributorApp
//
//  Created by VindicatoIOS on 11/21/13.
//  Copyright (c) 2013 VindicatoIOS. All rights reserved.
//

#import "UserLoged.h"
#import "CompanyModel.h"

@implementation UserLoged

-(void)convertToUserLoged:(NSDictionary *)data{
    [self setUsername:[data objectForKey:@"Username"]];
    [self setType:[data objectForKey:@"Type"]];
    [self setSessionKey:[data objectForKey:@"SessionKey"]];
    [self setFirstName:[data objectForKey:@"FirstName"]];
    [self setSecondName:[data objectForKey:@"SecondName"]];
    [self setLastName:[data objectForKey:@"LastName"]];
    
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    
    NSArray* mails1 =[data objectForKey:@"Mails"];
    for (NSString* mail in mails1) {
        [arr addObject:mail];
    }
    [self setMails:arr];
    
    [arr removeAllObjects];
    
    NSArray* phones1 =[data objectForKey:@"Phones"];
    
    for (NSString* phone in phones1) {
        [arr addObject:phone];
    }
    [self setPhones:arr];
    
    [arr removeAllObjects];
    
    NSDictionary* companyData =[data objectForKey:@"Company"];
    
    CompanyModel* company = [[CompanyModel alloc]init];
    
    [company setName:[companyData objectForKey:@"Name"]];
    [company setDisplayName:[companyData objectForKey:@"DisplayName"]];
    [company setFax:[companyData objectForKey:@"Fax"]];
    [company setMoreInformation:[companyData objectForKey:@"MoreInformation"]];
    [company setLocation:[companyData objectForKey:@"Location"]];
    
    
    
    NSArray* mails =[companyData objectForKey:@"Mails"];
    for (NSString* mail in mails) {
        [arr addObject:mail];
    }
    [company setMails:arr];
    
    [arr removeAllObjects];
    
    NSArray* phones =[companyData objectForKey:@"Phones"];
    
    for (NSString* phone in phones) {
        [arr addObject:phone];
    }
    [company setPhones:arr];
    
    if (![self Company]) {
        self.Company = [[CompanyModel alloc] init];
    }
    [self setCompany:company];
    
    //[company setMails:mails];
    //NSMutableArray* phones =  [companyData objectForKey:@"Phones"];
    //[company setMails:phones];
    
    //[self setCompany:company];
    
    //[[self Company] setMails:[companyData objectForKey:@"Mails"]];
    //[[self Company] setPhones:[companData objectForKey:@"Phones"]];
    //[[self Company] setType:[companyData objectForKey:@"Type"]];
    
}
/*
[registerRequest setRegistrationAuthCode:[json objectForKey:@"AuthCode"]];
[registerRequest setEmail:[json objectForKey:@"Email"]];
[registerRequest setType:[json objectForKey:@"Type"]];
[registerRequest setCompanyName:[json objectForKey:@"Company"]];
 */
@end
