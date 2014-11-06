//
//  AppManager.h
//  Wild Shop
//
//  Created by TL Nguyen on 11/6/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface AppManager : NSObject

@property (nonatomic, retain) PFUser *loggedUser;
@property (nonatomic, retain) NSMutableArray *itemsData;

+ (id) getManager;
-(NSArray *) getEntriesByCategory: (int)category;
-(NSArray *) getAllEntries;

@end
