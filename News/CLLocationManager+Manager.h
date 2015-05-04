//
//  CLLocationManager+Manager.h
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocationManager (Manager)

+(CLLocationManager *) sharedLocationManager;
-(void) startUpdatingLocationWithDelegate:(id) delegate;
-(void) stopUpdating;

@end
