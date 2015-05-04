//
//  ARFNew.h
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface ARFNewsEntity : PFObject <PFSubclassing>


@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) PFObject *user;
@property(nonatomic, strong) NSString *average;
@property(nonatomic, strong) PFFile * photoThumbnail;
@property(nonatomic, assign) NSUInteger * state;


+ (NSString *)parseClassName;

+(id) createNewWithTitle:(NSString *) title
                    text:(NSString *) text
                   photo:(UIImage *) image
                location:(CLLocation *) location;


@end
