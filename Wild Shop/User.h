//
//  User.h
//  Wild Shop
//
//  Created by TL Nguyen on 11/9/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;

@end
