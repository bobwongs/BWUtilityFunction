//
//  AppDelegate.m
//  BWUtilityFunction
//
//  Created by Bob Wong on 16/7/21.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *arrayLang = [NSLocale preferredLanguages];
    NSString *lang = [arrayLang firstObject];
    NSLog(@"arrayLang is %@, lang name is %@", arrayLang, lang);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arrayLang2 = [defaults objectForKey:@"AppleLanguages"];
    NSString *lang2 = [arrayLang2 objectAtIndex:0];
    NSLog(@"arrayLang2 is %@, lang2 name is %@", arrayLang2, lang2);
    
    NSArray *arrayLang3 = [[NSBundle mainBundle] preferredLocalizations];
    NSString *lang3 = [arrayLang3 firstObject];
    NSLog(@"arrayLang3 is %@, lang3 name is %@", arrayLang3, lang3);
    
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
