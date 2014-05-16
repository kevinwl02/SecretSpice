//
//  SSPPlaceViewController.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPPlaceViewController.h"
#import "SSPPlace.h"

@interface SSPPlaceViewController ()

@end

@implementation SSPPlaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([self.place.latitude doubleValue],
                                                                 [self.place.longitude doubleValue]);
    [annotation setCoordinate:location];
    [annotation setTitle:self.place.name];
    [annotation setSubtitle:self.place.address];
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.05f, 0.05f))];
    id<MKAnnotation> currentAnnotation = self.mapView.annotations[0];
    [self.mapView selectAnnotation:currentAnnotation
                          animated:YES];
}

@end
