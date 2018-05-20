//
//  Contact.h
//  Contacts1
//
//  Created by Jacob Harris on 5/20/18.
//  Copyright © 2018 Sneeze & Cookie, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString *contactID;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *streetAddress1;
@property (nonatomic, strong) NSString *streetAddress2;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipCode;

@end
