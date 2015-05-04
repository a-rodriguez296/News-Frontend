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
#import <Parse/PFObject+Subclass.h>

@implementation ARFScore

+(id) createScoreWithScore:(double) score
                   withNew:(ARFNewsEntity *) newsEntity{
    
    PFObject *scoreEntity = [PFObject objectWithClassName:kScoreEntityName];
    [scoreEntity setObject:[NSNumber numberWithDouble:score] forKey:kScoreEntityScore];
    [scoreEntity setObject:newsEntity forKey:kScoreEntityNew];
    [scoreEntity setObject:[PFUser currentUser] forKey:kNewsEntityAuthor];
    return scoreEntity;
}


+ (NSString *)parseClassName {
    return kScoreEntityName;
}

+ (void)load {
    [self registerSubclass];
}
@end
