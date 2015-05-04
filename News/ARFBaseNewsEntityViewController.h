//
//  ARFCreateNewsEntityViewController.h
//  News
//
//  Created by Alejandro Rodriguez on 4/29/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARFBaseViewController.h"

@interface ARFBaseNewsEntityViewController : ARFBaseViewController


//Views Properties
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtNewsText;
@property (nonatomic, strong) UIBarButtonItem * btnAddNews;
@property (weak, nonatomic) IBOutlet UIImageView *imgNews;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *btnAddImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBarAddImage;
@property (weak, nonatomic) IBOutlet UIButton *btnPublish;


@end
