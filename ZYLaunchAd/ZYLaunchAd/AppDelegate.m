//
//  AppDelegate.m
//  ZYLaunchAd
//
//  Created by mac on 17/5/1.
//  Copyright (c) 2017年 zy. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYLaunchAdController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    ZYLaunchAdController *launchAdVC = [[ZYLaunchAdController alloc] initLaunchAdSetUpAdImageView:^(UIImageView *imageView) {
        imageView.image = [UIImage imageNamed:@"cm2_reward_gift"];
    } finishHandler:^(ZYLaunchAdCallBackType finishHandler) {
        switch (finishHandler) {
            case ZYLaunchAdCallBackTypeClickAd:
                NSLog(@"点击了广告页");
                break;
            case ZYLaunchAdCallBackTypeClickSkip:
                NSLog(@"点击了跳过按钮");
                break;
            case ZYLaunchAdCallBackTypeClickFinish:
                NSLog(@"倒计时结束完成界面跳转");
                break;
            default:
                break;
        }
    }];
    launchAdVC.currentTime = 8.f;
    launchAdVC.setUpSkipBtn = ^(UIButton *skipBtn, NSInteger currentTime) {
        [skipBtn setTitle:[NSString stringWithFormat:@"%lds 跳过",currentTime] forState:UIControlStateNormal];
    };
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = launchAdVC;
    
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
