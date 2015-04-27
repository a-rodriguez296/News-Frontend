//
//  AppDelegate.m
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

//Borrar
#import "ARFNew.h"
#import "ARFScore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Configuración Parse
    [Parse setApplicationId:@"LkcDLQrgBOx3WrlsQdF7CbWoRxRheZNFhYEUDNbt" clientKey:@"vb1cj7WchFanF4RJnyjab78TbEFrkJoH8Cj3CxVT"];
    
//    ARFNew *new = [ARFNew createNewWithTitle:@"Noticia" text:@"noticia Prueba" photo:[UIImage imageNamed:@"imgPrueba.jpg"] author:@"Alejandro"];
//    [new saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
//        
//    }];
    
    PFQuery *query = [PFQuery queryWithClassName:@"New"];
    [query whereKey:@"objectId" equalTo:@"J2MccbWFhb"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        
        ARFNew *newsEntity = [objects firstObject];
        for (int i = 0; i<99; i++) {
            
            ARFScore *score = [ARFScore createScoreWithScore:2.5 withNew:newsEntity];
            [score saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                
            }];
        }
        
    }];
    
    
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
