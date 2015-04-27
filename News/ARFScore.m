//
//  ARFScore.m
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFScore.h"
#import "ARFNewsEntity.h"
#import "ARFConstants.h"

@implementation ARFScore

+(id) createScoreWithScore:(double) score
                   withNew:(ARFNewsEntity *) newsEntity{
    
    PFObject *scoreEntity = [PFObject objectWithClassName:kScoreEntityName];
    [scoreEntity setObject:[NSNumber numberWithDouble:score] forKey:kScoreEntityScore];
    [scoreEntity setObject:newsEntity forKey:kScoreEntityNew];
    
    return scoreEntity;
}

@end
