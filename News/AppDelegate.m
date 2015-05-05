//
//  AppDelegate.m
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "ARFNewsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "GAI.h"
#import "GAITracker.h"

//Borrar
#import "ARFNewsEntity.h"
#import "ARFScore.h"

@interface AppDelegate () <PFLogInViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Configuración Parse
    [ARFNewsEntity load];
    [ARFScore load];
    [Parse setApplicationId:@"LkcDLQrgBOx3WrlsQdF7CbWoRxRheZNFhYEUDNbt" clientKey:@"vb1cj7WchFanF4RJnyjab78TbEFrkJoH8Cj3CxVT"];
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];

    //Configuración Google Analytics
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-62622368-1"];
    
    if (![PFUser currentUser]) {
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.delegate = self;
        [logInController setFields:PFLogInFieldsFacebook];
        [logInController setFacebookPermissions:@[@"public_profile",@"email",@"user_friends"]];
        self.window.rootViewController = logInController;
    }
    else{
        ARFNewsViewController *newsVC =  [[ARFNewsViewController alloc] init];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:newsVC];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

-(void) createData{

    
//    ARFNewsEntity *new = [ARFNewsEntity createNewWithTitle:@"Noticia" text:@"noticia Prueba" photo:[UIImage imageNamed:@"imgPrueba.jpg"] author:@"Alejandro"];
//    [new saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
//        
//    }];
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"NewsEntity"];
//    [query whereKey:@"objectId" equalTo:@"WLrQWa6dix"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
//        
//        ARFNewsEntity *newsEntity = [objects firstObject];
//        for (int i = 0; i<99; i++) {
//            
//            ARFScore *score = [ARFScore createScoreWithScore:2.5 withNew:newsEntity];
//            [score saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
//                
//            }];
//        }
//        
//    }];
}

#pragma mark PFLogInViewControllerDelegate
- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    ARFNewsViewController *newsVC =  [[ARFNewsViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:newsVC];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {}

-(void)logInViewController:(PFLogInViewController * __nonnull)logInController didFailToLogInWithError:(nullable NSError *)error{}

@end
