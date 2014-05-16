//
//  SSPPlaceViewController.h
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class SSPPlace;

@interface SSPPlaceViewController : UIViewController

@property (nonatomic, strong) SSPPlace *place;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
