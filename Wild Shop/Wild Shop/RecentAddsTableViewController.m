//
//  RecentAddsTableViewController.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "RecentAddsTableViewController.h"
#import "EntryManager.h"
#import "DetailsViewController.h"
#import "AppManager.h"

@interface RecentAddsTableViewController ()

//RADI mock data
//@property EntryManager *manager;

@property AppManager *manager;
@property NSArray * items;

@end

@implementation RecentAddsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.items = [self.manager getRecentEntriesWithCount:15];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //RADI mock data
//    self.manager = [EntryManager getManager];
    
    self.manager = [AppManager getManager];
    
    self.items = [self.manager getRecentEntriesWithCount:15];
    
    //[self.tableView setDataSource:self];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    long row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"latestAddCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"latestAddCell"];
    }
    
    //RADI mock data
//    AddEntry *currentEntry = self.items[row];
//    
//    cell.textLabel.text = currentEntry.entryTitle;
//    cell.detailTextLabel.text = currentEntry.entryDetail;
//    UIImage *currentImage = [UIImage imageNamed:currentEntry.entryAvatar];
//    [cell.imageView setImage:currentImage];
    
    Item *currentEntry = self.items[row];
    
    cell.textLabel.text = currentEntry.title;
    cell.detailTextLabel.text = currentEntry.detail;
//    UIImage *currentImage = [UIImage imageNamed:currentEntry.entryAvatar];
//    [cell.imageView setImage:currentImage];

    return  cell;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    long row = [path row];
    if ([segue.identifier isEqualToString:@"recentAddsToDetailSegue"]) {
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
