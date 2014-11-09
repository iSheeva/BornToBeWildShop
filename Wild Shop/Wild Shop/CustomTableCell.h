//
//  CustomTableCell.h
//  Wild Shop
//
//  Created by Admin on 11/9/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@end
