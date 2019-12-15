//
//  AppDelegate.m
//  POCExample
//
//  Created by Mini on 14/12/19.
//  Copyright © 2019 Mini. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    UINavigationController *rootController = [[UINavigationController alloc]initWithRootViewController:[[FeedViewController alloc]init]];
    self.window.rootViewController = rootController;
    return YES;
}

@end
