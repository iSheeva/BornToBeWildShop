//
//  EntryManager.h
//  Wild Shop
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddEntry.h"

@interface EntryManager : NSObject

@property (nonatomic, strong) NSMutableArray *entriesData;

+ (instancetype)getManager;

-(void) initializeEntries;
-(AddEntry *) getEntryAtIndex: (int)index;
-(NSArray *) getAllEntries;
-(NSArray *) getEntriesByCategory: (int)category;
-(NSArray *) getEntriesByAuthor: (NSString *) author;
-(NSArray *) getRecentEntriesWithCount: (int)count;
-(void) addNewEntry: (AddEntry *)entry;
-(void) addNewEntry: (AddEntry *)entry
            atIndex: (int)index;
-(void) removeEntry: (AddEntry *)entry;
-(void) removeEntryAtIndex: (int)index;

@end
