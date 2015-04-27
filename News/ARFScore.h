//
//  ARFScore.h
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class ARFNewsEntity;

@interface ARFScore : PFObject <PFSubclassing>

+(id) createScoreWithScore:(double) score
                   withNew:(ARFNewsEntity *) newsEntity;

+ (NSString *)parseClassName;

@end
