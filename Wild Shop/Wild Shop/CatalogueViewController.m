//
//  CatalogueViewController.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "CatalogueViewController.h"
#import <Parse/Parse.h>
#import "AddEntry.h"

@interface CatalogueViewController ()
@property NSArray * categories;
@property NSArray * items;
@property NSArray * data;
@end

@implementation CatalogueViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"catalogue will appear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [AddEntry createEntries];
    
    [self.customTableView setDataSource:self];
    // Do any additional setup after loading the view, typically from a nib.
    self.categories = @[@"none", @"vehicles", @"parts", @"accessories"];
    self.items = [AddEntry getAllEntries];
    self.data = [NSArray arrayWithArray:self.items];
    
    NSLog(@"in catalogue");
    NSLog(@"%@", [PFUser currentUser]);
    // Do any additional setup after loading the view.
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
            self.data = [AddEntry getEntriesFrom:self.items ByCategory:1];
            [self.customTableView reloadData];
            break;
        }
        case 2:
            background = [UIColor yellowColor];
            self.data = [AddEntry getEntriesFrom:self.items ByCategory:2];
            [self.customTableView reloadData];
            break;
        case 3:
            background = [UIColor redColor];
            self.data = [AddEntry getEntriesFrom:self.items ByCategory:3];
            [self.customTableView reloadData];
            break;
        default:
            background = [UIColor whiteColor];
            self.data = [self.items copy];
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
    AddEntry *currentEntry = self.data[row];
    
    cell.textLabel.text = currentEntry.entryTitle;
    cell.detailTextLabel.text = currentEntry.entryDetail;
    UIImage *currentImage = [UIImage imageNamed:currentEntry.entryAvatar];
    [cell.imageView setImage:currentImage];
    return  cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

// SET BACK BUTTON DESTINATION
-(IBAction)goToThisView:(UIStoryboardSegue *) segue{
    //id source = [segue sourceViewController];
    //id destination = [segue destinationViewController];
    [[[UIAlertView alloc] initWithTitle:@"You are back" message:@"Welcome" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
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
