//
//  MapViewController.h
//  Wild Shop
//
//  Created by Admin on 11/7/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic)CLLocation *currentLocation;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
