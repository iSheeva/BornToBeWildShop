//
//  DetailsViewController.h
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEntry.h"
#import "Item.h"

@interface DetailsViewController : UIViewController

//RADI mock data
//@property (weak, nonatomic) AddEntry *currentEntry;

@property (weak, nonatomic) Item *currentEntry;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemDescription;
@property (weak, nonatomic) IBOutlet UIImageView *itemAvatar;
@property (weak, nonatomic) IBOutlet UILabel *itemCreationDate;
@property (weak, nonatomic) IBOutlet UILabel *itemContacts;
@property (weak, nonatomic) IBOutlet UILabel *itemAuthor;
@property (weak, nonatomic) IBOutlet UIButton *showLocationButton;

@end
