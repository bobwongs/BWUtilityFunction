//
//  BWLanguageManager.m
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/4.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWLanguageManager.h"

@implementation BWLanguageManager

NSString *const kTextUnknownError = @"未知错误!";

+ (BOOL)isSimpleChinese
{
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    if ([language hasPrefix:@"zh-Hans"]) {
        return 1;
    }
    else {
        return 0;
    }
}

+ (NSString *)keyWithErrorCode:(NSString *)errorCode {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BWLanguageConfig" ofType:@"plist"];
    NSDictionary *dictConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *dictErrorCode = dictConfig[@"ErrorCode"];
    
    NSString *key = dictErrorCode[errorCode];
    if (!key || key.length == 0) {
        key = kTextUnknownError;
    }
    return key;
}

@end
