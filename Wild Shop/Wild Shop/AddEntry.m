//
//  AddEntry.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//
#define ARC4RANDOM_MAX 0x100000000
#define START NSDate* das

#import "AddEntry.h"
@implementation AddEntry

static int year = 60*60*24*30*12;
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
        NSDate *date = [self getRandomDateFrom:[NSDate dateWithTimeIntervalSince1970:43 * year]
                                            to:[NSDate date]];
        self.entryDate = date;
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

-(NSDate *)getRandomDateFrom:(NSDate *) startDate
                          to:(NSDate *) endDate {
    NSTimeInterval timeBetweenDates = [endDate timeIntervalSinceDate:startDate];
    NSTimeInterval randomInterval = ((NSTimeInterval)arc4random() / ARC4RANDOM_MAX) * timeBetweenDates;
    
    return [startDate dateByAddingTimeInterval:randomInterval];
}

-(NSString *)description {
    return [NSString stringWithFormat:@" Title: %@ Date: %@", self.entryTitle, self.entryDate];
}

@end
