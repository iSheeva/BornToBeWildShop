//
//  AddEntry.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "AddEntry.h"
@implementation AddEntry

static NSMutableArray *entriesData;

-(instancetype)init{
    return [self initWithTitle:@"Motorcycle" withDetails:@"Yamaha" withContacts:@"+359 888 555 222" withAuthor:@"ivan" withAvatar:@"motorcycle" withCategory:1];
}

-(instancetype)initWithTitle: (NSString *)title
                 withDetails: (NSString *)details
                withContacts: (NSString *)contacts
                  withAuthor: (NSString *)author
                  withAvatar: (NSString *)avatar
                withCategory: (int) category {
    self = [super init];
    if (self) {
        self.entryTitle = title;
        self.entryDetail = details;
        self.entryContacts = contacts;
        self.entryAuthor= author;
        self.entryAvatar = avatar;
        self.entryCategory = category;
        self.entryLocation = [[NSDictionary alloc] init];
        self.entryDate = [NSDate date];
    }
    return  self;
}

- (NSComparisonResult)compare:(AddEntry *)otherObject {
    return [otherObject.entryDate compare:self.entryDate];
}

+(instancetype) addEntry {
    return [[AddEntry alloc] initWithTitle:@"Motorcycle" withDetails:@"Yamaha" withContacts:@"+359 888 555 222" withAuthor:@"ivan" withAvatar:@"motorcycle" withCategory:1];
    
}

+(instancetype) addEntryWithTitle: (NSString *)title
                      withDetails: (NSString *)details
                             with: (NSString *)contacts
                       withAuthor: (NSString *)author
                       withAvatar: (NSString *)avatar
                     withCategory: (int) category{
    return [[AddEntry alloc] initWithTitle:title withDetails:details withContacts:contacts withAuthor:author withAvatar:avatar withCategory:category];
}

+(NSArray *) createEntries{
    entriesData = [[NSMutableArray alloc] init];
    NSArray *usernames = @[@"ivan", @"pesho", @"radi" ];
    for (int j = 0; j < usernames.count; j++) {
        NSString *currentUser = usernames[j];
        
        for (int i = 0; i < 4; i++) {
            [AddEntry addNewEntry:[[AddEntry alloc]initWithTitle: [NSString
                                                                   stringWithFormat:@"Part By %@", currentUser]
                                                     withDetails:@"Part Details"
                                                    withContacts:@"+359 888 555 222"
                                                      withAuthor:currentUser
                                                      withAvatar:@"part"
                                                    withCategory:2]];
            [AddEntry addNewEntry:[[AddEntry alloc]initWithTitle: [NSString
                                                                   stringWithFormat:@"Motorcycle By %@", currentUser]
                                                     withDetails:@"Motor details"
                                                    withContacts:@"+359 888 555 222"
                                                      withAuthor:currentUser
                                                      withAvatar:@"motorcycle"
                                                    withCategory:1]];
            [AddEntry addNewEntry:[[AddEntry alloc]initWithTitle: [NSString
                                                                   stringWithFormat:@"Accessory By %@", currentUser]
                                                     withDetails:@"Accessory Details"
                                                    withContacts:@"+359 888 555 222"
                                                      withAuthor:currentUser
                                                      withAvatar:@"accessory"
                                                    withCategory:3]];
        }
    }
    
    return  entriesData;
}

+(AddEntry *) getEntryAtIndex:(int)index {
    return [entriesData objectAtIndex:index];
}
+(NSArray *) getAllEntries{
    return  entriesData;
}
+(NSArray *) getEntriesFrom:(NSArray *)entries
                 ByCategory:(int)category {
    NSMutableArray *filteredEntries = [[NSMutableArray alloc] init];
    for (AddEntry* entry in entries) {
        if (entry.entryCategory == category) {
            [filteredEntries addObject:entry];
        }
    }
    
    return  filteredEntries;
}
+(NSArray *) getEntriesFrom: (NSArray *)entries
                   ByAuthor: (NSString *)author {
    NSMutableArray *filteredEntries = [[NSMutableArray alloc] init];
    for (AddEntry* entry in entries) {
        if (entry.entryAuthor == author) {
            [filteredEntries addObject:entry];
        }
    }
    
    return  filteredEntries;
}
+(NSArray *) getRecentEntriesWithCount: (int)count {
    NSArray *sortedArray;
    sortedArray = [entriesData sortedArrayUsingSelector:@selector(compare:)];
    return [sortedArray subarrayWithRange:NSMakeRange(0, count)];
}
+(void) addNewEntry: (AddEntry *)entry{
    [entriesData addObject:entry];
    
}
+(void) addNewEntry: (AddEntry *)entry
            atIndex:(int) index{
    [entriesData insertObject:entry atIndex:index];
    
}
+(void) removeEntry: (AddEntry *)entry {
    [entriesData removeObject:entry];
}
+(void) removeEntryAtIndex: (int)index{
    [entriesData removeObjectAtIndex:index];
}

-(NSString *)description {
    return [NSString stringWithFormat:@" Title: %@ Date: %@", self.entryTitle, self.entryDate];
}

@end
