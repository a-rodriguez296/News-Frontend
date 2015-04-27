//
//  ARFScore.h
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@class ARFNew;

@interface ARFScore : PFObject

+(id) createScoreWithScore:(double) score
                   withNew:(ARFNew *) newsEntity;

@end
