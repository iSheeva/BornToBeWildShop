//
//  LoginViewController.m
//  Wild Shop
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "LoginViewController.h"
#import "Item.h"
#import "AppManager.h"

@interface LoginViewController () {
    PFUser *_user;
}

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (IBAction)login:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    
    _user = [PFUser logInWithUsername:user.username password:user.password];
}

- (IBAction)register:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    
    if ([user signUp]) {
        NSString *registeredMessage = @"User registered successfuly, please login";
        [[[UIAlertView alloc] initWithTitle:@"Success Register" message:registeredMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    } else {
        NSString *errorString = @"User Already Exist";
        [[[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (_user && _user.isAuthenticated) {
        return YES;
    }
    else {
        NSString *errorString = @"Wrong password or username";
        [[[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
        return NO;
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    [[AppManager sharedManager] setLoggedUser:_user];
    
    PFQuery *query = [Item query];
    NSArray *items = [query findObjects];
    
    [[[AppManager sharedManager] itemsData] addObjectsFromArray:items];
    
}

// SET LOGOUT BUTTON DESTINATION
-(IBAction)goToThisView:(UIStoryboardSegue *) segue{
    //id source = [segue sourceViewController];
    //id destination = [segue destinationViewController];
    [[[UIAlertView alloc] initWithTitle:@"You are out" message:@"You Logged Out! Please Come Back Soon!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}


@end
