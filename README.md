
# BWUtilityFunction

## 国际化
---
### Contents
- 国际化需求
	- 应用外语言切换
	- 应用内语言切换
- iOS本地化机制
- 本地化内容
- 应用内语言切换的开发经验
- 本地化开发经验
- Reference

### 国际化需求
- 应用外语言切换  
iOS系统语言切换，重启App之后使用对应的语言
- 应用内语言切换  
应用内置语言切换功能，参考微信、微博的语言切换  

### iOS本地化机制
- 国际化其实都大同小异，其核心思想就是为每种语言单独定义一份资源；  
- 项目源代码中如果有多个不同目录的国际化资源，则会有产生多个xxx.lproj，但在编译打包后，会集中放在App的根目录中的xxx.lproj中；iOS就是通过xxx.lproj目录来定义每个语言的资源，这里的资源可以是图片，文本，Storyboard，Xib等；  
- 本地化App的包资源命名和iOS系统对语言的命名
    - 包资源（对打包出来的App文件显示包内容，本地化资源后缀名为.lproj，l:Localization）
        - Base.lproj
        - en.lproj
        - en-GB.lproj(UK)
        - zh-Hans.lproj
    - iOS系统对语言的命名（带有地区标识）
        - "en-CN"
        - "en-GB"
        - "zh-Hans-CN"(S: Sample, 简体中文)
        - "zh-Hant-CN"(T: Traditional, 繁体中文)
    - 运用  
        通过获得系统语言或者自定义的语言，去从Bundle中获得正确的本地化资源包，实现应用内语言的切换；

### 本地化内容
- App Display Name  
iOS App名字国际化步骤（实质为Info.plist文件的国际化）
    - 添加一个StringFile，命名为InfoPlist.strings。并且在文件属性里将所需要的多国语言勾上；
    - 添加一条新的多语言记录，CFBundleDisplayName，并对其做多语言处理；
    - 在targets->info里面添加一条新的记录，Application has localized display name， 并将值设为YES；
- iOS系统语言环境的获取
- 文本
	- 通过一个Localizable.strings文件来存储每个语言的文本，它是iOS默认加载的文件，如果想用自定义名称命名，在使用NSLocalizedString方法时指定tableName为自定义名称就好了，此宏定义方法有指定tableName来获得对应.strings文件中的语言文本，tableName即为.strings的文件名，但你的应用规模不是很大就不要分模块搞特殊了；
	- 每一套语言新建一份strings，其内容采用"key" = "value";的格式，注意有;号；
	- Localizable.strings(Simplified)文件可以不要的(可以理解为中文为APP的默认语言)，因为key就是value，当找不到相应的语言strings或value时会直接返回key。nice！这样一来我们做文本的国际化就只要维护一个英文副本strings就O了；
- 图片
	- 方式一：自定义文本命名，缺点：一是因为做法太low了，工作量明显加大；二是不能在Storyboard或XIB中使用；
	- 方式二：原生支持，Base副本去掉。另外需要注意的是，使用这种方式，在XIB或Storyboard中引用图片时如果只使用名称是实时显示不了的，一定要加上后缀名。如image.png；
- Xib和Storyboard
	- Xcode为我们提供了ibtool工具来生成Xib/Storyboard的strings文件
		- ibtool --generate-strings-file Mystring.strings MyXib.xib
	- 但是ibtool生成的strings文件是BaseStoryboard的strings(默认语言的strings)，且会把我们原来的strings替换掉。所以我们要做的就是把新生成的strings与旧的strings进行冲突处理(新的附加上，删除掉的注释掉)，这一切可以用这个python脚本来实现，见AutoGenStrings.py
                脚本使用示例，针对xib
		- python AutoGenStrings.py BWUtilityFunction/ViewController/Internationalization/Xib

### 应用内语言切换的开发经验
- 开发实现
	- 本地缓存语言类型标识，定义NSBundle，路径为当前语言的“.lproj”文件目录；切换语言时，创建指向新语言路径的NSBundle替换旧的；
- 实现方案一：手动管理自定义的语言资源NSBundle对象  
弊端：Xib、Storyboard中的文本需要从代码中去编写，直接设置在对应本地化文件中的文本是不会随着指向新语言路径的_bundle的改变而改变；
- 实现方案二：使用NSBundle的扩展，通过运行时重写NSBundle的获取本地化文本的实例方法  
弊端：图片还是指向原来语言资源的文件，解决方法：扩展UIImageView，从对应的语言资源目录去获取图片资源，并且在User Defined Runtime Attributed中做属性设置；
- 语言
	- en
	- zh-Hans
- 尽力避免使用Force NSLocalizedString
    <pre>
    [userDefaults setObject:@[languageToSet] forKey:@"AppleLanguages"];
    [userDefaults synchronize];
    </pre>
	- Force NSLocalizedString to use a specific language to have the app in a different language than the device;
	- 这个需要重启App才能看到效果，没有在应用内即时刷新，重启后[NSBundle mainBundle]会指向对应的语言资源，不用在系统中修改；
	- 强烈建议不使用此方式，因为代码强制修改了AppleLanguages，如果再次修改系统的语言，此时从这个应用中获得的AppleLanguages不会随着系统语言修改而做改变，AppleLanguages的值仍然是手动修改后的值，获取不了系统的语言配置；
- Reset UI
	- 为了使整个项目都进行语言的切换，进行重置AppDelegate.window的rootViewController，或者有更好的办法进行重置，待研究；

### 本地化开发经验
- 在相应目录下创建了对应的配置目录和文件，谨慎使用移动和更改文件目录的操作，如果需要使用，则对原来配置过本地化的文件再配置一次，会提醒是否需要用原来的文件，此时选择使用原来的文件就好了，同时也要注意文件备份才是比较保险的方法；  
- 不同国家的语言
	- 尽量把同一个VC的词语翻译成差不多长的其他语言，一个好长一个非常短的，我们该这么去适配呢？而我们最简单的做法是
btn.titleLabel.adjustsFontSizeToFitWidth = YES;
- Xib和Storyboard的国际化
	- 编辑文本UI时，使用脚本重新生成.strings文件，如果直接使用Xcode工具会把原来配置好的语言给替换掉；
- BWLanguageManager
    - 语言管理类；

### Reference	 
<http://www.cocoachina.com/ios/20151120/14258.html>  
<https://github.com/maximbilan/ios_language_manager>

---

## 开发经验总结
---
- UI搭建
	- Storyboard感觉还是不够稳定，项目开发优先使用手写代码+Xib搭建界面的方式；
- 脚本
	- 脚本运行
		- Xcode - Run Script
		- Shell终端使用命令运行
	- 脚本的作用
    	- 便捷地对文件、代码进行修改，不用编译、运行才能使用，脚本是解析执行的；
    - 脚本语言
    	- Shell
        - Python
- 宏定义和在方法外定义常量的区别
	- 方法未定义的常量，给常量赋初值时不能包含方法，宏定义可以，宏定义原理是宏替换；
- 养成良好的开发习惯
	- 定期备份、及时备份的开发习惯；
- 调研
    - 贴上Reference资源；  
- Assets.xcassets
	- Xcode中Assets.xcassets资源打包后是在包内容Assets.car；
    
### Follow Me
---
Github: <https://github.com/BobWongs>
