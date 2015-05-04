//
//  ARFUser.h
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/Parse.h>

@interface ARFUser : PFObject <PFSubclassing>

@property(nonatomic, strong) NSString *username;

+ (NSString *)parseClassName;

@end
