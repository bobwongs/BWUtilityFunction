//
//  BWLocalizeViewController.m
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/3.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWLocalizeViewController.h"

@interface BWLocalizeViewController ()

@end

@implementation BWLocalizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Localization";
    
    [self setUI];
}

- (void)setUI {
    NSString *keyLabel0 = @"发现";
    UILabel *label0 = [[UILabel alloc] init];
    label0.textAlignment = NSTextAlignmentCenter;
    label0.text = NSLocalizedString(keyLabel0, nil);
    [self.view addSubview:label0];
    
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
    }];
}

@end
