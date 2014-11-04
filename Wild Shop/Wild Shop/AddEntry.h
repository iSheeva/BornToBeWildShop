//
//  AddEntry.h
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <Foundation/Foundation.h>
enum category {
    none,
    motorcycles,
    parts,
    accessories
};

@interface AddEntry : NSObject

@property (nonatomic) NSString *entryTitle;
@property (nonatomic) NSString *entryDetail;
@property (nonatomic) NSString *entryContacts;
@property (nonatomic) NSString *entryAuthor;
@property (nonatomic) NSString *entryAvatar;
@property int entryCategory;
@property (nonatomic) NSDictionary *entryLocation;
@property (nonatomic) NSDate *entryDate;

-(instancetype)init;
-(instancetype)initWithTitle: (NSString *)title
                 withDetails: (NSString *)details
                withContacts: (NSString *)contacts
                  withAuthor: (NSString *)author
                  withAvatar: (NSString *)avatar
                withCategory: (int) category;
- (NSComparisonResult)compare: (AddEntry *)otherObject;

+(instancetype) addEntry;
+(instancetype) addEntryWithTitle: (NSString *)title
                      withDetails: (NSString *)details
                             with: (NSString *)contacts
                       withAuthor: (NSString *)author
                       withAvatar: (NSString *)avatar
                     withCategory: (int) category;
+(NSArray *) createEntries;
+(AddEntry *) getEntryAtIndex: (int)index;
+(NSArray *) getAllEntries;
+(NSArray *) getEntriesFrom: (NSArray *)entries
                 ByCategory: (int)category;
+(NSArray *) getEntriesFrom: (NSArray *)entries
                   ByAuthor: (NSString *) author;
+(NSArray *) getRecentEntriesWithCount: (int)count;
+(void) addNewEntry: (AddEntry *)entry;
+(void) addNewEntry: (AddEntry *)entry
            atIndex: (int)index;
+(void) removeEntry: (AddEntry *)entry;
+(void) removeEntryAtIndex: (int)index;

@end
