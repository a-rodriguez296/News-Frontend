//
//  ARFNew.m
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFNewsEntity.h"
#import "ARFConstants.h"

@implementation ARFNewsEntity

+(id) createNewWithTitle:(NSString *) title
                    text:(NSString *) text
                   photo:(UIImage *) image
                  author:(NSString *) author{
    PFObject * newObject = [PFObject objectWithClassName:kNewsEntityName];
    [newObject setObject:title forKey:kNewsEntityTitle];
    [newObject setObject:text forKey:kNewsEntityText];
    
    //Creación imagen
    PFFile *imgFile = [PFFile fileWithData:UIImageJPEGRepresentation(image, 1.0)];
    [newObject setObject:imgFile forKey:kNewsEntityPhoto];
    
    [newObject setObject:author forKey:kNewsEntityAuthor];
    
    return newObject;
}

@end
