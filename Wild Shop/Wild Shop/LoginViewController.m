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
#import "CoreDataHelper.h"
#import "User.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property(nonatomic, strong) CoreDataHelper* cdHelper;

@end

@implementation LoginViewController

- (IBAction)login:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    
    [[AppManager getManager] setLoggedUser: [PFUser logInWithUsername:user.username password:user.password]];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"username like %@", user.username];
    [request setPredicate:predicate];
    
     NSArray *fetchedObjects = [_cdHelper.context executeFetchRequest:request error:nil];
    
    if ([fetchedObjects count] == 0 && [[[AppManager getManager] loggedUser] isAuthenticated]) {
        User *cdUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:_cdHelper.context];
        
        cdUser.username = user.username;
        cdUser.password = user.password;
        
        [_cdHelper.context insertObject:cdUser];
        [self.cdHelper saveContext];
    }
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
    _cdHelper = [[CoreDataHelper alloc] init];
    [_cdHelper setupCoreData];
    
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"%@", currentUser.username);
    if (currentUser) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"username like %@", currentUser.username];
        [request setPredicate:predicate];
        
        NSArray *fetchedObjects = [_cdHelper.context executeFetchRequest:request error:nil];
        
        if ([fetchedObjects count] == 1) {
            User *cdUser = fetchedObjects[0];
            
            PFUser *user = [PFUser user];
            user.username = cdUser.username;
            user.password = cdUser.password;
            
            [[AppManager getManager] setLoggedUser: [PFUser logInWithUsername:user.username password:user.password]];
            
            self.username.text = cdUser.username;
            self.password.text = cdUser.password;
            
            //        [self.loginButton sendActionsForControlEvents: UIControlEventTouchUpInside];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    PFUser *loggedUser = [[AppManager getManager] loggedUser];
    
    if (loggedUser && loggedUser.isAuthenticated) {
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
    
    PFQuery *query = [Item query];
    NSArray *items = [query findObjects];
    
    [[[AppManager getManager] itemsData] addObjectsFromArray:items];
    
}

// SET LOGOUT BUTTON DESTINATION
-(IBAction)goToThisView:(UIStoryboardSegue *) segue{
    //id source = [segue sourceViewController];
    //id destination = [segue destinationViewController];
    [PFUser logOut];
    [[[UIAlertView alloc] initWithTitle:@"You are out" message:@"You Logged Out! Please Come Back Soon!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}


@end
