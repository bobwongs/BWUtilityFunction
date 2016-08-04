//
//  BWLanguageManager.h
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/4.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWLanguageManager : NSObject

+ (BOOL)isSimpleChinese;    ///< 是否为简体中文
+ (NSString *)keyWithErrorCode:(NSString *)errorCode;   ///< 根据ErrorCode获得对应的Key

@end
