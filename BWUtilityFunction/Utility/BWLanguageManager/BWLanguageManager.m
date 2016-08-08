//
//  BWLanguageManager.m
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/4.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWLanguageManager.h"

#define NSStandardUserDefaults [NSUserDefaults standardUserDefaults]

NSString *const kAppLanguage = @"kAppLanguage";
NSString *const kEN = @"en";
NSString *const kCN = @"zh-Hans";

@interface BWLanguageManager ()

@property (nonatomic, strong) NSBundle *bundle;  //!< Bundle of Language

@end

@implementation BWLanguageManager

NSString *const kTextUnknownError = @"未知错误!";

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static BWLanguageManager *_sharedManager = nil;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
        
        NSString *language = [NSStandardUserDefaults objectForKey:kAppLanguage];
        if (!language || language.length == 0) {
            // 跟随系统语言
            NSString *languageSystem = [[NSLocale preferredLanguages] firstObject];
            if ([languageSystem containsString:kEN]) {
                language = kEN;
            }
            else if ([languageSystem containsString:kCN]) {
                language = kCN;
            }
        }
        _sharedManager.language = language;
    });
    return _sharedManager;
}

- (void)setLanguage:(NSString *)language
{
    if (!language || language.length == 0) {
        return ;
    }
    
    _language = language;
    [NSStandardUserDefaults setObject:_language forKey:kAppLanguage];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:_language ofType:@"lproj"];
    _bundle = [NSBundle bundleWithPath:path];
}

- (NSString *)localizedStringWithKey:(NSString *)key
{
    if (!_bundle) {
        return @"";
    }
    
    return [_bundle localizedStringForKey:key value:nil table:nil];
}

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
