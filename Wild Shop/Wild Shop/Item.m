//
//  Item.m
//  Wild Shop
//
//  Created by TL Nguyen on 11/4/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "Item.h"

@implementation Item

@dynamic title;
@dynamic detail;
@dynamic contacts;
@dynamic author;
@dynamic avatar;
@dynamic category;
@dynamic location;

+(NSString *)parseClassName {
    return @"Item";
}

+(void)load {
    [self registerSubclass];
}

@end
