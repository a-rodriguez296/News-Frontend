//
//  ARFContainerViewController.m
//  News
//
//  Created by Alejandro Rodriguez on 5/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFContainerViewController.h"
#import "ARFNewsViewController.h"

@interface ARFContainerViewController ()


@end

@implementation ARFContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its ni
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    ARFNewsViewController *newsVC = [[ARFNewsViewController alloc] init];
    [self addChildViewController:newsVC];
    newsVC.view.frame = self.containerView.frame;
    [self.containerView addSubview:newsVC.view];
    [newsVC didMoveToParentViewController:self];
    [self.view layoutIfNeeded];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"News"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didChangeSegment:(id)sender {
}

@end
