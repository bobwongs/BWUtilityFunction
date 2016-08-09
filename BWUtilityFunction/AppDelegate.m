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

@end
