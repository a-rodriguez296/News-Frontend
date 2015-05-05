//
//  ARFCreateNewsViewController.m
//  News
//
//  Created by Alejandro Rodriguez on 4/29/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCreateNewsViewController.h"
#import "ARFConstants.h"
#import "UIImage+Resize.h"
#import "ARFNewsEntity.h"
#import "CLLocationManager+Manager.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@interface ARFCreateNewsViewController ()

@property(nonatomic, strong) CLLocation *location;

@end

@implementation ARFCreateNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CLLocationManager sharedLocationManager] startUpdatingLocationWithDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"Create a New"];
    [self setScreenName:@"Create a new screen"];
    self.btnAddNews = [[UIBarButtonItem alloc] initWithTitle:@"Add New" style:UIBarButtonItemStylePlain target:self action:@selector(addNewsObject:)];
    [self.btnAddNews setEnabled:NO];
    [self.navigationItem setRightBarButtonItem:self.btnAddNews];
    
    [self.btnAddImage addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBarAddImage setTarget:self];
    [self.btnBarAddImage setAction:@selector(takePicture:)];
}

#pragma mark IBACtions
- (void)takePicture:(id)sender {
    
    // Crear uipicker
    UIImagePickerController *picker = [UIImagePickerController new];
    
    // configurar
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    picker.delegate = self;
    
    // mostrar
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void) addNewsObject:(id) sender{
    
    //Analytics
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Create" action:@"Create New" label:@"" value:nil] build]];
    
    ARFNewsEntity *newsEntity = [ARFNewsEntity createNewWithTitle:self.txtTitle.text text:self.txtNewsText.text photo:self.imgNews.image location:self.location];
    _ME_WEAK
    [self startLoadingAnimationWithFlag:YES];
    [self.view setUserInteractionEnabled:NO];
    [newsEntity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        [me startLoadingAnimationWithFlag:NO];
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma UITextViewDelegate
-(void)textViewDidEndEditing:(UITextView *)textView{
    [self checkAddNewButton];
}

#pragma UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self checkAddNewButton];
}

#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _ME_WEAK
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        UIImage *resizedImage = [originalImage resizedImage:CGSizeMake(originalImage.size.width*0.75, originalImage.size.height*0.75) interpolationQuality:0.8];
        dispatch_async(dispatch_get_main_queue(), ^{
            [me.imgNews setImage:resizedImage];
            [me checkAddNewButton];
        });
        
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [manager stopUpdating];
    [self setLocation:[locations lastObject]];
}

#pragma mark Utils
-(void) checkAddNewButton{
    
    BOOL enabled = self.txtNewsText.text.length>0 && self.txtTitle.text.length>0 && self.imgNews.image;
    [self.btnAddNews setEnabled:enabled];
}

-(void)startLoadingAnimationWithFlag:(BOOL) flag{
    
    if (flag)
        [self.activityIndicator startAnimating];
    else
        [self.activityIndicator stopAnimating];
    
    [self.view setUserInteractionEnabled:!flag];
}
@end
