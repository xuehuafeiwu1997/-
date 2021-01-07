//
//  AppDelegate.m
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/10.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NSUserDefaultViewController.h"
#import "ArchiveViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
//    ViewController *vc = [[ViewController alloc] init];
//    NSUserDefaultViewController *vc = [[NSUserDefaultViewController alloc] init];
    ArchiveViewController *vc = [[ArchiveViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    return YES;
}

@end
