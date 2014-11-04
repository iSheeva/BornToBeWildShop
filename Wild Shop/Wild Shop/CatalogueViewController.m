//
//  CatalogueViewController.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "CatalogueViewController.h"
#import <Parse/Parse.h>

@interface CatalogueViewController ()

@end

@implementation CatalogueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"in catalogue");
    NSLog(@"%@", [PFUser currentUser]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
