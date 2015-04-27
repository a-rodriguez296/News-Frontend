//
//  ARFNewsHeader.m
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFNewsHeader.h"

@interface ARFNewsHeader ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end


@implementation ARFNewsHeader

-(void)awakeFromNib{
    [self.segmentedControl addObserver:self forKeyPath:@"selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:nil];


}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"selectedSegmentIndex"]) {
        
        UISegmentedControl *control = (UISegmentedControl *) object;
        if (self.delegate) {
            [self.delegate didPressSegmentWithIndex:control.selectedSegmentIndex];
        }
    }
}

-(void) setSegmentSelectedIndex:(NSUInteger) index{
    
    [self.segmentedControl setSelectedSegmentIndex:index];
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"selectedSegment"];
}

@end
