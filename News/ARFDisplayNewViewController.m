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
#import "ARFScore.h"
#import "PFObject+Utils.h"

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
    
    
    UIBarButtonItem *btnAddScore = [[UIBarButtonItem alloc] initWithTitle:@"Add Score" style:UIBarButtonItemStylePlain target:self action:@selector(addScore:)];
    self.navigationItem.rightBarButtonItem = btnAddScore;
    [self.btnPublish setHidden:NO];
    
    [self syncWithModel];
}


#pragma mark IBActions
-(void) addScore:(id) sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add a score to this new" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    //Creación del action
    _ME_WEAK
    UIAlertAction * sendScore = [UIAlertAction actionWithTitle:@"Send Score" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *txtScore = alertController.textFields[0];
        double dScore = [txtScore.text doubleValue];
        ARFScore *score =[ARFScore createScoreWithScore:dScore withNew:me.newsEntity];
        [score saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            [self dismissViewControllerAnimated:alertController completion:nil];
        }];
        
    }];
    
    //Adición del textfield
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:textField queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [sendScore setEnabled:(textField.text.length>0)];
        }];
        [textField setPlaceholder:@"Score 0.0 - 5.0."];
        [textField setKeyboardType:UIKeyboardTypeDecimalPad];
    }];
  
    
    

    [sendScore setEnabled:NO];
    


    [alertController addAction:sendScore];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
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
    [self.btnPublish setEnabled:[PFObject compareWithLocalUserWithUser:self.newsEntity.user]];
}

@end
