//
//  BWLocalizeViewController.m
//  BWUtilityFunction
//
//  Created by BobWong on 16/8/3.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWLocalizeViewController.h"
#import "BWLocalizeView.h"

@interface BWLocalizeViewController ()

@end

@implementation BWLocalizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Localization";
    
    [self setUI];
}

- (void)setUI {
    /*================
        文本国际化
        通过一个Localizable.strings文件来存储每个语言的文本，它是iOS默认加载的文件，如果想用自定义名称命名，在使用NSLocalizedString方法时指定tableName为自定义名称就好了，此宏定义方法有指定tableName来获得对应.strings文件中的语言文本，tableName即为.strings的文件名，但你的应用规模不是很大就不要分模块搞特殊了；
         每一套语言新建一份strings，其内容采用"key" = "value";的格式，注意有;号；
         strings【Localizable.strings(Simplified)】可以不要的(可以理解为中文为APP的默认语言)，因为key就是value，当找不到相应的语言strings或value时会直接返回key。nice！这样一来我们做文本的国际化就只要维护一个英文副本strings就O了；
     ================*/
    NSString *keyLabel0 = @"发现";
    UILabel *label0 = [[UILabel alloc] init];
    label0.textAlignment = NSTextAlignmentCenter;
    label0.text = NSLocalizedString(keyLabel0, nil);
    [self.view addSubview:label0];
    
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
    }];
    
    /*================
        图片国际化
        方式一：自定义文本命名，缺点：一是因为做法太low了，工作量明显加大；二是不能在Storyboard或XIB中使用；
        方式二：原生支持，Base副本去掉。另外需要注意的是，使用这种方式，在XIB或Storyboard中引用图片时如果只使用名称是实时显示不了的，一定要加上后缀名。如image.png
        以下为方式二
     ================*/
    UIImageView * imageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image0"]];
    [self.view addSubview:imageView0];
    [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(label0.mas_bottom).offset(20);
        make.width.height.mas_equalTo(100);
    }];
    
    /*================
        Xib国际化
            Xcode为我们提供了ibtool工具来生成Xib/Storyboard的strings文件
                ibtool --generate-strings-file Mystring.strings MyXib.xib
            但是ibtool生成的strings文件是BaseStoryboard的strings(默认语言的strings)，且会把我们原来的strings替换掉。所以我们要做的就是把新生成的strings与旧的strings进行冲突处理(新的附加上，删除掉的注释掉)，这一切可以用这个python脚本来实现，见AutoGenStrings.py
                脚本使用示例，针对xib
                    python AutoGenStrings.py BWUtilityFunction/ViewController/Internationalization/Xib
     ================*/
    BWLocalizeView *viewLocalize = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BWLocalizeView class]) owner:self options:nil].firstObject;
    [self.view addSubview:viewLocalize];
    
    [viewLocalize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(imageView0.mas_bottom).offset(10);
        make.height.mas_equalTo(150);
    }];
}

@end
