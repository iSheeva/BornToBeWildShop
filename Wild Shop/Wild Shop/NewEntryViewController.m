//
//  NewEntryViewController.m
//  Wild Shop
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "NewEntryViewController.h"
#import "AppManager.h"

@interface NewEntryViewController ()

@property NSArray *categories;
@property AppManager *manager;

//RADI mock data
//@property EntryManager *manager;

@end

@implementation NewEntryViewController {
    NSString *title;
    NSString *detail;
    PFUser *author;
    NSString *contact;
    PFFile *avatar;
    int category;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = @[@"all", @"motorcycle", @"part", @"accessory"];
    
    //RADI mock data
//    self.manager = [EntryManager getManager];
    
    self.manager = [AppManager getManager];
    
    author = self.manager.loggedUser;
    category = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
         picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    
    avatar = [PFFile fileWithName:@"image.png" data:imageData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
    
    //RADI mock data
//    AddEntry *newEntry = [[AddEntry alloc] initWithTitle:title withDetails:detail withContacts:contact withAuthor:author withAvatar:avatar withCategory:category];
//    newEntry.entryDate = [NSDate date];
    
    Item *newEntry = [[Item alloc] init];
    newEntry.title = title;
    newEntry.detail = detail;
    newEntry.contacts = contact;
    newEntry.author = author;
    newEntry.category = category;
    
    NSLog(@"%@", avatar);
    newEntry.avatar = avatar;
    
    if ([self.manager addNewEntry:newEntry atIndex:0]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self showMessage:@"Server error"];
    }
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
