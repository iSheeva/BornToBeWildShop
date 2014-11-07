//
//  DetailsViewController.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    
    //RADI mock data
//    self.itemTitle.text = self.currentEntry.entryTitle;
//    self.itemDescription.text = self.currentEntry.entryDetail;
//    self.itemContacts.text = self.currentEntry.entryContacts;
//    self.itemAuthor.text = self.currentEntry.entryAuthor;
//    self.itemCreationDate.text = [formatter stringFromDate:self.currentEntry.entryDate];
//    [self.itemAvatar setImage:[UIImage imageNamed:self.currentEntry.entryAvatar]];
    
    self.itemTitle.text = self.currentEntry.title;
    self.itemDescription.text = self.currentEntry.detail;
    self.itemContacts.text = self.currentEntry.contacts;
    self.itemCreationDate.text = [formatter stringFromDate:self.currentEntry.createdAt];
    
    //get author async
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:self.currentEntry.author.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                PFUser *itemAuthor = [objects objectAtIndex:0];
                self.itemAuthor.text = itemAuthor.username;
            });
        }
    }];
    
    //get avatar async
    [self.currentEntry.avatar getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.itemAvatar setImage:[UIImage imageWithData: data]];
            });
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToCatalogues:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
