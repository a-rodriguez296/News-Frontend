//
//  ARFDisplayNewViewController.h
//  News
//
//  Created by Alejandro Rodriguez on 4/29/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBaseNewsEntityViewController.h"
@class ARFNewsEntity;


@interface ARFDisplayNewViewController : ARFBaseNewsEntityViewController


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil newsEntity:(ARFNewsEntity *) newsEntity;

@end
