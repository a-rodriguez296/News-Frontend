//
//  ARFUser.m
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFUser.h"
#import <Parse/PFObject+Subclass.h>
#import "ARFConstants.h"

@implementation ARFUser


@dynamic username;

+ (NSString *)parseClassName {
    return kUserEntityName;
}

+ (void)load {
    [self registerSubclass];
}

@end
