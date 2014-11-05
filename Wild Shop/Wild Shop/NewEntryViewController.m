//
//  NewEntryViewController.m
//  Wild Shop
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "NewEntryViewController.h"

@interface NewEntryViewController ()

@property NSArray * categories;
@property EntryManager *manager;

@end

@implementation NewEntryViewController {
    NSString *title;
    NSString *detail;
    NSString *author;
    NSString *contact;
    NSString *avatar;
    int category;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = @[@"all", @"motorcycle", @"part", @"accessory"];
    self.manager = [EntryManager getManager];
    author = @"radi";
    category = 0;
    avatar = self.categories[category];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPicture:(id)sender {
    [self showMessage:@"Option is in construction!"];
}

- (IBAction)selectLocation:(id)sender {
    [self showMessage:@"Option is in construction!"];
}

- (IBAction)saveNewEntry:(id)sender {
    title = self.inputTitle.text;
    if (![self checkInput:title]) {
        [self showMessage:[NSString stringWithFormat: @"Title must be at least 5 symbols long"]];
         return;
    }
         
    detail = self.inputDescription.text;
    if (![self checkInput:detail]) {
        [self showMessage:[NSString stringWithFormat: @"Details must be at least 5 symbols long"]];
        return;
    }
    
    contact = self.inputContact.text;
    if (![self checkInput:contact]) {
        [self showMessage:[NSString stringWithFormat: @"Please provide valid contact information."]];
        return;
    }
    
    AddEntry *newEntry = [[AddEntry alloc] initWithTitle:title withDetails:detail withContacts:contact withAuthor:author withAvatar:avatar withCategory:category];
    newEntry.entryDate = [NSDate date];
    [self.manager addNewEntry:newEntry atIndex:0];
    [self dismissViewControllerAnimated:YES completion:nil];
}
         
-(void)showMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@"Invalid Input" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

-(BOOL)checkInput:(NSString *) input {
    if (input == nil || [input isEqualToString:@""] || input.length < 5) {
        return NO;
    }
    return  YES;
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
    category = (int)row;
    avatar = self.categories[category];
    UIColor * background;
    switch (row) {
        case 1:
            background = [UIColor greenColor];
            break;
        case 2:
            background = [UIColor yellowColor];
            break;
        case 3:
            background = [UIColor redColor];
            break;
        default:
            background = [UIColor cyanColor];
            break;
    }
    
    //self.showSelectionLabel.text = self.categories[row];
    self.view.backgroundColor = background;
    
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
