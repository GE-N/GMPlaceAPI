//
//  AppDelegate.m
//  GeoSearch
//
//  Created by Ignacio on 10/17/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    
    _viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
    _window.rootViewController = navigationController;
    
    return YES;
}

@end
