//
//  BWLocalizeViewController.h
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/3.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWBaseViewController.h"

@interface BWLocalizeViewController : BWBaseViewController

@property (nonatomic, copy) dispatch_block_t blockResetVC;  //!< 切换语言，重置VC

@end
