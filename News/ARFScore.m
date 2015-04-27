//
//  ARFScore.m
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFScore.h"
#import "ARFNew.h"

@implementation ARFScore

+(id) createScoreWithScore:(double) score
                   withNew:(ARFNew *) newsEntity{
    
    PFObject *scoreEntity = [PFObject objectWithClassName:@"Score"];
    [scoreEntity setObject:[NSNumber numberWithDouble:score] forKey:@"score"];
    [scoreEntity setObject:newsEntity forKey:@"new"];
    
    return scoreEntity;
}

@end
