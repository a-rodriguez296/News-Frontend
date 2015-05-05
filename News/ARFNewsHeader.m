//
//  ARFNewsHeader.m
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFNewsHeader.h"

@implementation ARFNewsHeader


- (IBAction)onTouchSegment:(id)sender {
    
    UISegmentedControl *control = (UISegmentedControl *) sender;
    if (self.delegate) {
        [self.delegate didPressSegmentWithIndex:control.selectedSegmentIndex];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
