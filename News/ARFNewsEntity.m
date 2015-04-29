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

@implementation ARFNewsEntity


@dynamic title;
@dynamic text;


+ (NSString *)parseClassName {
    return kNewsEntityName;
}

+ (void)load {
    [self registerSubclass];
}

+(id) createNewWithTitle:(NSString *) title
                    text:(NSString *) text
                   photo:(UIImage *) image{
    PFObject * newObject = [PFObject objectWithClassName:kNewsEntityName];
    [newObject setObject:title forKey:kNewsEntityTitle];
    [newObject setObject:text forKey:kNewsEntityText];
    
    //Creación imagen
    PFFile *imgFile = [PFFile fileWithData:UIImageJPEGRepresentation(image, 1.0)];
    [newObject setObject:imgFile forKey:kNewsEntityPhoto];
    
    [newObject setObject:[PFUser currentUser] forKey:kNewsEntityAuthor];
    
    return newObject;
}

@end
