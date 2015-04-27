//
//  CLLocationManager+Manager.m
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "CLLocationManager+Manager.h"

@implementation CLLocationManager (Manager)

+(CLLocationManager *) sharedLocationManager{
    static CLLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CLLocationManager alloc] init];
    });
    
    return (CLLocationManager *)manager;
}


-(void) startUpdatingLocationWithDelegate:(id) delegate{
    
    [self setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self setDelegate:delegate];
    
    if ([self respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self requestWhenInUseAuthorization];
    }
    [self startUpdatingLocation];
    
}

-(void) stopUpdating{
    self.delegate = nil;
    [self stopUpdatingLocation];
}


@end
