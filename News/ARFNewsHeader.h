//
//  ARFNewsHeader.h
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderSegmentDelegate <NSObject>

@required
-(void) didPressSegmentWithIndex:(NSUInteger) index;

@end

@interface ARFNewsHeader : UIView

@property(nonatomic, weak) id<HeaderSegmentDelegate> delegate;


@end
