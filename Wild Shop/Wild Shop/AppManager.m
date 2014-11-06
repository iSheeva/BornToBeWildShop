//
//  AppManager.m
//  Wild Shop
//
//  Created by TL Nguyen on 11/6/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "AppManager.h"
#import "Item.h"

@implementation AppManager

static AppManager *sharedMyManager = nil;

+ (id) getManager {
    if (sharedMyManager == nil) {
        sharedMyManager = [[self alloc] init];
    }
    
    return sharedMyManager;
}

- (id)init {
    if ( (self = [super init]) ) {
        self.itemsData = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *) getEntriesByCategory: (int)category {
    NSMutableArray *filteredEntries = [[NSMutableArray alloc] init];
    for (Item *item in self.itemsData) {
        if (item.category == category) {
            [filteredEntries addObject:item];
        }
    }
    
    return  filteredEntries;
}

-(NSArray *) getAllEntries {
    return self.itemsData;
}


@end
