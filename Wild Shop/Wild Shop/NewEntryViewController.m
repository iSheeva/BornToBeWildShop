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
    NSString *entryTitle;
    NSString *entryDetail;
    PFUser *entryAuthor;
    NSString *entryContact;
    PFFile *entryAvatar;
    int entryCategory;
    
    // LOCATION FIELDS
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocation *currentLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = @[@"all", @"motorcycle", @"part", @"accessory"];
    
    // INITIALIZE LOCATION FIELDS
    [self.progressBar stopAnimating];
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    
    //RADI mock data
//    self.manager = [EntryManager getManager];
    
    self.manager = [AppManager getManager];
    
    entryAuthor = self.manager.loggedUser;
    entryCategory = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// make keyboard disappear if we touch anything else
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - CLLocationManagerDelegate methods
- (IBAction)getCurrentLocation:(id)sender {
    [self.progressBar stopAnimating];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    [self.progressBar startAnimating];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.progressBar stopAnimating];
    currentLocation = [locations lastObject];
    
    if (currentLocation == nil) {
        [self locationManager:locationManager didFailWithError:[[NSError alloc] init]];
        return;
    }
    
    double currentLongitude = currentLocation.coordinate.longitude;
    double currentLatitude = currentLocation.coordinate.latitude;
    NSMutableString *locationString = [NSMutableString stringWithFormat:@"Latitude: %.8f \n Longitude: %.8f \n",
                                currentLatitude, currentLongitude];
    
    [locationManager stopUpdatingLocation];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSString *addressInfo = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                        placemark.subThoroughfare != nil ? placemark.subThoroughfare : @"",
                                        placemark.thoroughfare != nil ? placemark.thoroughfare : @"",
                                        placemark.postalCode != nil ? placemark.postalCode : @"",
                                        placemark.locality != nil ? placemark.locality : @"",
                                        placemark.administrativeArea != nil ? placemark.administrativeArea : @"",
                                        placemark.country != nil ? placemark.country : @""];
            if (placemark != nil) {
                [locationString appendString:addressInfo];
            }
            
            [self showMessage:locationString withTitle:@"Location Info"];
        } else {
            [self showMessage:locationString withTitle:@"Location Info"];
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.progressBar stopAnimating];
    [[[UIAlertView alloc] initWithTitle:@"Location error" message:@"Cannot detect location! Check you connectivity and permissions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show ];
}


// GET PICTURE BUTTON ACTION
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
    
    entryAvatar = [PFFile fileWithName:@"image.png" data:imageData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)saveNewEntry:(id)sender {
    entryTitle = self.inputTitle.text;
    if (![self checkInput:entryTitle]) {
        [self showMessage:[NSString stringWithFormat: @"Title must be at least 5 symbols long"] withTitle:@"Invalid Title"];
         return;
    }
         
    entryDetail = self.inputDescription.text;
    if (![self checkInput:entryDetail]) {
        [self showMessage:[NSString stringWithFormat: @"Description must be at least 5 symbols long"] withTitle:@"Invalid Description"];
        return;
    }
    
    entryContact = self.inputContact.text;
    if (![self checkInput:entryContact]) {
        [self showMessage:[NSString stringWithFormat: @"Please provide valid contact information."] withTitle:@"Invalid Contact Info"];
        return;
    }
    
    //RADI mock data
//    AddEntry *newEntry = [[AddEntry alloc] initWithTitle:title withDetails:detail withContacts:contact withAuthor:author withAvatar:avatar withCategory:category];
//    newEntry.entryDate = [NSDate date];
    
    Item *newEntry = [[Item alloc] init];
    newEntry.title = entryTitle;
    newEntry.detail = entryDetail;
    newEntry.contacts = entryContact;
    newEntry.author = entryAuthor;
    newEntry.category = entryCategory;
    
    if (currentLocation != nil) {
        PFGeoPoint *point = [PFGeoPoint geoPointWithLocation:currentLocation];
        newEntry.location = point;
    }
    
    NSLog(@"%@", entryAvatar);
    newEntry.avatar = entryAvatar;
    
    if ([self.manager addNewEntry:newEntry atIndex:0]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self showMessage:@"Server error" withTitle:@"Error Information"];
    }
}
         
-(void)showMessage:(NSString *)message withTitle:(NSString *)title {
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
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
    entryCategory = (int)row;
    entryAvatar = self.categories[entryCategory];
    UIColor * background;
    switch (row) {
        case 1:
            background = [UIColor magentaColor];
            break;
        case 2:
            background = [UIColor orangeColor];
            break;
        case 3:
            background = [UIColor redColor];
            break;
        default:
            background = [UIColor colorWithRed:137 green:121 blue:255 alpha:0.3];
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
