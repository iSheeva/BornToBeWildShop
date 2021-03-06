//
//  NewEntryViewController.h
//  Wild Shop
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryManager.h"
#import <CoreLocation/CoreLocation.h>

@interface NewEntryViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTitle;
@property (weak, nonatomic) IBOutlet UITextView *inputDescription;
@property (weak, nonatomic) IBOutlet UITextField *inputContact;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;

@end
