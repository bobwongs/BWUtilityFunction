//
//  UIImageView+BWExtension.m
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/9.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "UIImageView+BWExtension.h"
#import "NSBundle+BWExtension.h"

@implementation UIImageView (BWExtension)

- (NSString *)localizedImageName {
    return @"";
}

- (void)setLocalizedImageName:(NSString *)localizedImageName {
    if (!localizedImageName || localizedImageName.length == 0) {
        return ;
    }
    
    NSBundle *bundle = [NSBundle getLanguageBundle];
    NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"%@@2x", localizedImageName] ofType:@"png"];
    self.image = [UIImage imageWithContentsOfFile:path];
}

- (void)localized {
    
}

@end
