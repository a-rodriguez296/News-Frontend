//
//  ARFCreateNewsViewController.h
//  News
//
//  Created by Alejandro Rodriguez on 4/29/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBaseNewsEntityViewController.h"
@import CoreLocation;


@protocol CreateNewsViewControllerDelegate <NSObject>

@optional
-(void) didCreateNewsEntity;

@end


@interface ARFCreateNewsViewController : ARFBaseNewsEntityViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>


@property(nonatomic, weak) id<CreateNewsViewControllerDelegate> delegate;

@end
