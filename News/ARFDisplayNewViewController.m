//
//  ARFDisplayNewViewController.m
//  News
//
//  Created by Alejandro Rodriguez on 4/29/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFDisplayNewViewController.h"
#import "ARFNewsEntity.h"
#import "ARFConstants.h"

@interface ARFDisplayNewViewController ()

@property (nonatomic, strong) ARFNewsEntity *newsEntity;

@end

@implementation ARFDisplayNewViewController


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil newsEntity:(ARFNewsEntity *) newsEntity{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _newsEntity = newsEntity;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setScreenName:@"Display new"];
    [self.txtTitle setUserInteractionEnabled:NO];
    [self.txtNewsText setUserInteractionEnabled:NO];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self syncWithModel];
}


#pragma mark Utils
-(void) syncWithModel{
    [self.toolBar setHidden:YES];
    [self.txtTitle setText:self.newsEntity.title];
    [self.txtNewsText setText:self.newsEntity.text];
    _ME_WEAK
    [[self.newsEntity objectForKey:kNewsEntityPhoto] getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        [me.imgNews setImage:[UIImage imageWithData:data]];
    }];
}

@end
