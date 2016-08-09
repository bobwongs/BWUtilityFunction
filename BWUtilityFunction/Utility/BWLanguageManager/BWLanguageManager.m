//
//  BWLanguageManager.m
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/4.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWLanguageManager.h"
#import "NSBundle+BWExtension.h"

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
            // 如果App没有设置的语言，跟随系统语言
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
    
    
    /*================
        手动管理自定义的NSBundle对象
        弊端：Xib、Storyboard中的文本需要从代码中去编写，直接设置在对应本地化文件中的文本是不会随着指向新语言路径的_bundle的改变而改变
    ================*/
//    NSString *path = [[NSBundle mainBundle] pathForResource:_language ofType:@"lproj"];
//    _bundle = [NSBundle bundleWithPath:path];
    
    
    /*================
        使用NSBundle的扩展
        弊端
            图片还是指向原来语言资源的文件
            解决方法：扩展UIImageView，并且在User Defined Runtime Attributed做属性设置
     ================*/
    [NSBundle setLanguage:_language];
    _bundle = [NSBundle getLanguageBundle];
}

- (NSString *)localizedStringWithKey:(NSString *)key
{
//    if (!_bundle) {
//        return @"";
//    }
//    return [_bundle localizedStringForKey:key value:nil table:nil];
    
    return [[NSBundle mainBundle] localizedStringForKey:key value:nil table:nil];
}

+ (BOOL)isSimpleChinese
{
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    if ([language containsString:@"zh-Hans"]) {
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
