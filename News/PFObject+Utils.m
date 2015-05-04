//
//  PFUser+Utils.m
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "PFObject+Utils.h"

@implementation PFObject (Utils)

+(BOOL) compareWithLocalUserWithUser:(PFObject *) object{
    
    return [[object objectId] isEqual:[[PFUser currentUser] objectId]];
}

@end
