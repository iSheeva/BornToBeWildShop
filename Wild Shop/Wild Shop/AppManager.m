//
//  AppManager.m
//  Wild Shop
//
//  Created by TL Nguyen on 11/6/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

static AppManager *sharedMyManager = nil;

+ (id) sharedManager {
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

@end
