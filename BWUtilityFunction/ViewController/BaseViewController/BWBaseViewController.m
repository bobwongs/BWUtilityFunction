//
//  BWBaseViewController.m
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/3.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWBaseViewController.h"

@implementation BWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)dealloc {
    NSLog(@"%@ vc object has been deallocd", NSStringFromClass([self class]));
}

@end
