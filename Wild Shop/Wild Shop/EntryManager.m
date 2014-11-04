//
//  EntryManager.m
//  Wild Shop
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "EntryManager.h"

@implementation EntryManager

+ (instancetype)getManager {
    static EntryManager *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil) {
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.entriesData = [[NSMutableArray alloc] init];
        [self initializeEntries];
    }
    return self;
}

-(void) initializeEntries{
    NSArray *usernames = @[@"ivan", @"pesho", @"radi" ];
    for (int j = 0; j < usernames.count; j++) {
        NSString *currentUser = usernames[j];
        
        for (int i = 0; i < 4; i++) {
            [self addNewEntry:[[AddEntry alloc]initWithTitle: [NSString
                                                                   stringWithFormat:@"Part By %@", currentUser]
                                                     withDetails:@"Part Details"
                                                    withContacts:@"+359 888 555 222"
                                                      withAuthor:currentUser
                                                      withAvatar:@"part"
                                                    withCategory:2]];
            [self addNewEntry:[[AddEntry alloc]initWithTitle: [NSString
                                                                   stringWithFormat:@"Motorcycle By %@", currentUser]
                                                     withDetails:@"Motor details"
                                                    withContacts:@"+359 888 555 222"
                                                      withAuthor:currentUser
                                                      withAvatar:@"motorcycle"
                                                    withCategory:1]];
            [self addNewEntry:[[AddEntry alloc]initWithTitle: [NSString
                                                                   stringWithFormat:@"Accessory By %@", currentUser]
                                                     withDetails:@"Accessory Details"
                                                    withContacts:@"+359 888 555 222"
                                                      withAuthor:currentUser
                                                      withAvatar:@"accessory"
                                                    withCategory:3]];
        }
    }
}

-(AddEntry *) getEntryAtIndex:(int)index {
    return [self.entriesData objectAtIndex:index];
}

-(NSArray *) getAllEntries{
    return  self.entriesData;
}

-(NSArray *) getEntriesByCategory:(int)category {
    NSMutableArray *filteredEntries = [[NSMutableArray alloc] init];
    for (AddEntry* entry in self.entriesData) {
        if (entry.entryCategory == category) {
            [filteredEntries addObject:entry];
        }
    }
    
    return  filteredEntries;
}

-(NSArray *) getEntriesByAuthor: (NSString *)author {
    NSMutableArray *filteredEntries = [[NSMutableArray alloc] init];
    for (AddEntry* entry in self.entriesData) {
        if (entry.entryAuthor == author) {
            [filteredEntries addObject:entry];
        }
    }
    
    return  filteredEntries;
}

-(NSArray *) getRecentEntriesWithCount: (int)count {
    NSArray *sortedArray;
    sortedArray = [self.entriesData sortedArrayUsingSelector:@selector(compare:)];
    return [sortedArray subarrayWithRange:NSMakeRange(0, count)];
}

-(void) addNewEntry: (AddEntry *)entry{
    [self.entriesData addObject:entry];
    
}

-(void) addNewEntry: (AddEntry *)entry
            atIndex:(int) index{
    [self.entriesData insertObject:entry atIndex:index];
    
}

-(void) removeEntry: (AddEntry *)entry {
    [self.entriesData removeObject:entry];
}

-(void) removeEntryAtIndex: (int)index{
    [self.entriesData removeObjectAtIndex:index];
}

@end
