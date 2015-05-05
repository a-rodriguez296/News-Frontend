//
//  ARFNew.m
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFNewsEntity.h"
#import "ARFConstants.h"
#import <Parse/PFObject+Subclass.h>
@import CoreLocation;

@implementation ARFNewsEntity


@dynamic title;
@dynamic text;
@dynamic user;
@dynamic average;
@dynamic photoThumbnail;
@dynamic photo;
@dynamic state;
@dynamic author;

+ (NSString *)parseClassName {
    return kNewsEntityName;
}

+ (void)load {
    [self registerSubclass];
}

+(id) createNewWithTitle:(NSString *) title
                    text:(NSString *) text
                   photo:(UIImage *) image
                location:(CLLocation *) location{
    PFObject * newObject = [PFObject objectWithClassName:kNewsEntityName];
    
    //Atributos básicos
    [newObject setObject:title forKey:kNewsEntityTitle];
    [newObject setObject:text forKey:kNewsEntityText];
    
    //Creación imagen
    PFFile *imgFile = [PFFile fileWithData:UIImageJPEGRepresentation(image, 1.0)];
    [newObject setObject:imgFile forKey:kNewsEntityPhoto];
    
    //Autor
    [newObject setObject:[PFUser currentUser] forKey:kNewsEntityUser];
    
    PFGeoPoint * geoPoint = [PFGeoPoint geoPointWithLocation:location];
    [newObject setObject:geoPoint forKey:kNewsEntityGeopoint];
    
    return newObject;
}


@end
