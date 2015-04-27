//
//  ARFNew.m
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFNew.h"

@implementation ARFNew

+(id) createNewWithTitle:(NSString *) title
                    text:(NSString *) text
                   photo:(UIImage *) image
                  author:(NSString *) author{
    PFObject * newObject = [PFObject objectWithClassName:@"New"];
    [newObject setObject:title forKey:@"title"];
    [newObject setObject:text forKey:@"text"];
    
    //Creación imagen
    PFFile *imgFile = [PFFile fileWithData:UIImageJPEGRepresentation(image, 1.0)];
    [newObject setObject:imgFile forKey:@"photo"];
    
    [newObject setObject:author forKey:@"author"];
    
    return newObject;
}

@end
