//
//  LoginViewController.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "LoginViewController.h"
#import "Item.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (IBAction)login:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    
    [PFUser logInWithUsernameInBackground:user.username
                                 password:user.password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"logged in");
                                        } else {
                                            NSString *errorString = [error userInfo][@"error"];
                                            [[[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                        }
                                    }];
}

- (IBAction)register:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"registered");
            [self login:nil];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            [[[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

// SET LOGOUT BUTTON DESTINATION
-(IBAction)goToThisView:(UIStoryboardSegue *) segue{
    //id source = [segue sourceViewController];
    //id destination = [segue destinationViewController];
    [[[UIAlertView alloc] initWithTitle:@"You are out" message:@"You Logged Out! Please Come Back Soon!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}


@end
