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

-(NSArray *) getEntriesByAuthor: (NSString *) author {
    NSMutableArray *filteredEntries = [[NSMutableArray alloc] init];
    for (Item* item in self.itemsData) {
        NSLog(@"item authorId = %@, input authorId = %@", item.author, author);
        
        if ([item.author.objectId isEqualToString: author]) {
            [filteredEntries addObject:item];
        }
    }
    
    return  filteredEntries;
}

-(NSArray *) getRecentEntriesWithCount: (int)count {
    NSArray *sortedArray;
    sortedArray = [self.itemsData sortedArrayUsingSelector:@selector(compare:)];
    return [sortedArray subarrayWithRange:NSMakeRange(0, count <= [sortedArray count] ? count : [sortedArray
                                                       count])];
}

-(void) removeEntry: (Item *)entry {
    [entry deleteInBackground];
    [self.itemsData removeObject:entry];
}

-(BOOL) addNewEntry: (Item *)entry {
    if ([entry save]) {
        [self.itemsData addObject:entry];
        return YES;
    };
    return NO;
}

-(BOOL) addNewEntry: (Item *)entry
            atIndex:(int) index{
    if ([entry save]) {
        [self.itemsData insertObject:entry atIndex:index];
        return YES;
    }
    return NO;
}

@end
