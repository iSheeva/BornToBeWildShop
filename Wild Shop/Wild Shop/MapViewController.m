//
//  MapViewController.m
//  Wild Shop
//
//  Created by Admin on 11/7/14.
//  Copyright (c) 2014 Team Sheeva. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self.progressBar setHidden:NO];
    [self.progressBar startAnimating];
    [self performSelector:@selector(showLocationOnMap) withObject:self afterDelay:1.0 ];
    //[self showLocationOnMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLocationOnMap {
    CLLocationCoordinate2D currentCoordinate = self.currentLocation.coordinate;
    //CLLocationCoordinate2D currentCoordinate = userLocation.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentCoordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = currentCoordinate;
    point.title = @"Item Location";
    point.subtitle = @"Check it out!";
    [self.mapView addAnnotation:point];
    [self.progressBar stopAnimating];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// Call if using location update
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    
//    CLLocationCoordinate2D currentCoordinate = self.currentLocation.coordinate;
//    //CLLocationCoordinate2D currentCoordinate = userLocation.coordinate;
//    
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentCoordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = currentCoordinate;
//    point.title = @"Item Location";
//    point.subtitle = @"Check it out!";
//    [self.mapView addAnnotation:point];
//    [self.progressBar stopAnimating];
//}
@end
