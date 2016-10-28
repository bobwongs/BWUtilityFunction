//
//  NSBundle+BWExtension.h
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/8.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (BWExtension)

+ (void)setLanguage:(NSString *)language;
+ (NSBundle *)getLanguageBundle;

@end

@interface BundleEx : NSBundle

@end
