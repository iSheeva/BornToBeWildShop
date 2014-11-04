//
//  Item.h
//  Wild Shop
//
//  Created by TL Nguyen on 11/4/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Item : PFObject<PFSubclassing>

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSString *contacts;
@property (nonatomic) PFUser *author;
@property (nonatomic) PFFile *avatar;
@property int category;
@property (nonatomic) PFGeoPoint *location;

@end
