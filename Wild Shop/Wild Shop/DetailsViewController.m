//
//  DetailsViewController.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "DetailsViewController.h"
#import "MapViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    
    if (self.currentEntry.location != nil) {
        [self.showLocationButton setHidden:NO];
    }
    
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([[segue identifier] isEqualToString:@"showMapSegue"]) {
        MapViewController *mvc = [segue destinationViewController];
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.currentEntry.location.latitude longitude:self.currentEntry.location.longitude];
        mvc.currentLocation = currentLocation;
    }
    // Pass the selected object to the new view controller.
}

// SET BACK BUTTON DESTINATION
-(IBAction)goToDetails:(UIStoryboardSegue *) segue{
    //id source = [segue sourceViewController];
    //id destination = [segue destinationViewController];
//    [[[UIAlertView alloc] initWithTitle:@"Item warning" message:@"Item was not saved!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}


@end
