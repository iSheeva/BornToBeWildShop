//
//  CatalogueViewController.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "CatalogueViewController.h"
#import "DetailsViewController.h"
#import "EntryManager.h"
#import <Parse/Parse.h>
#import "AddEntry.h"
#import "AppManager.h"
#import "Item.h"

@interface CatalogueViewController ()

@property NSArray * categories;
@property NSArray * items;
@property AppManager *manager;

//RADI mock data
//@property EntryManager *manager;

@end

@implementation CatalogueViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"catalogue will appear");
    // REFRESH DATA TO DISPLAY IF NEW ENTRIES ARE ADDED
    self.items = [self.manager getAllEntries];
    [self.customTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //RADI mock data
//    self.manager = [EntryManager getManager];
    
    
    self.manager = [AppManager getManager];
    
    [self.customTableView setDataSource:self];
    // Do any additional setup after loading the view, typically from a nib.
    self.categories = @[@"all", @"vehicles", @"parts", @"accessories"];
    self.items = [self.manager getAllEntries];
    
    NSLog(@"in catalogue");
    NSLog(@"%@", [PFUser currentUser]);
    // Do any additional setup after loading the view.
    
    NSLog(@"test loggedUser from singleton object - %@", [[AppManager getManager] loggedUser]);
    
    NSLog(@"test itemsData from singleton object - %@", [[AppManager getManager] getAllEntries]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// SET NUMBER OF COMPONENTS IN PICKER
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// SET NUMBER OF ROWS IN COMPONENT
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.categories count];
}

// SET ITEM FOR EACH ROW
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.categories[row];
}

// SET ACTION ON COMPONENT SELECTED
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    UIColor * background;
    switch (row) {
        case 1: {
            background = [UIColor greenColor];
            self.items = [self.manager getEntriesByCategory:1];
            [self.customTableView reloadData];
            break;
        }
        case 2:
            background = [UIColor yellowColor];
            self.items = [self.manager getEntriesByCategory:2];
            [self.customTableView reloadData];
            break;
        case 3:
            background = [UIColor redColor];
            self.items = [self.manager getEntriesByCategory:3];
            [self.customTableView reloadData];
            break;
        default:
            background = [UIColor whiteColor];
            self.items = [self.manager getAllEntries];
            [self.customTableView reloadData];
            break;
    }
    
    //self.showSelectionLabel.text = self.categories[row];
    self.view.backgroundColor = background;
    
}

// SET CUSTOM TABLE VIEW
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    long row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"catalogueCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"catalogueCell"];
    }
    //RADI mock data
//    AddEntry *currentEntry = self.items[row];
    
//    Item *currentEntry = self.items[row];
//    
//    cell.textLabel.text = currentEntry.entryTitle;
//    cell.detailTextLabel.text = currentEntry.entryDetail;
//    UIImage *currentImage = [UIImage imageNamed:currentEntry.entryAvatar];
//    [cell.imageView setImage:currentImage];
    
    Item *currentEntry = self.items[row];
    
    cell.textLabel.text = currentEntry.title;
    cell.detailTextLabel.text = currentEntry.detail;
    [cell.imageView setImage: [UIImage imageWithData:currentEntry.avatar.getData]];

    return  cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

// SET BACK BUTTON DESTINATION
-(IBAction)goToThisView:(UIStoryboardSegue *) segue{
    //id source = [segue sourceViewController];
    //id destination = [segue destinationViewController];
    [[[UIAlertView alloc] initWithTitle:@"You are back" message:@"Welcome" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    NSIndexPath *path = [self.customTableView indexPathForSelectedRow];
    long row = [path row];
    if ([segue.identifier isEqualToString:@"catalogueToDetailSegue"]) {
        DetailsViewController *dvc = [segue destinationViewController];
        
        //RADI mock data
//        AddEntry *selectedEntry = self.items[row];
//        dvc.currentEntry = selectedEntry;
        
        Item *selectedEntry = self.items[row];
        dvc.currentEntry = selectedEntry;
    }
    // Pass the selected object to the new view controller.
}


@end
