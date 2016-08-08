
# BWUtilityFunction

## 国际化
- 实现目标
	- 在iOS系统选择不同语言地区时能够显示对应的语言；
	- 国际化内容
		- App Display Name
		- 文本
		- 图片
		- Xib和Storyboard
	- 应用内不同语言环境的切换（待完善）
- 本地化文件原理
	- 国际化其实都大同小异，其核心思想就是为每种语言单独定义一份资源；
    - iOS就是通过xxx.lproj目录来定义每个语言的资源，这里的资源可以是图片，文本，Storyboard，Xib等；
    - 项目源代码中如果有多个不同目录的国际化资源，则会有产生多个xxx.lproj，但在编译打包后，会集中放在App的根目录中的xxx.lproj中；
    - 在相应目录下创建了对应的配置目录和文件，谨慎使用移动和更改文件目录的操作，如果需要使用，则对原来配置过本地化的文件再配置一次，会提醒是否需要用原来的文件，此时选择使用原来的文件就好了，同时也要注意文件备份才是比较保险的方法；
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
- iOS App名字国际化（实质为Info.plist文件的国际化）
    - 添加一个StringFile，命名为InfoPlist.strings。并且在文件属性里将所需要的多国语言勾上；
    - 添加一条新的多语言记录，CFBundleDisplayName，并对其做多语言处理；
    - 在targets->info里面添加一条新的记录，Application has localized display name， 并将值设为YES；
- 不同国家的语言
	- 尽量把同一个VC的词语翻译成差不多长的其他语言，一个好长一个非常短的，我们该这么去适配呢？而我们最简单的做法是
btn.titleLabel.adjustsFontSizeToFitWidth = YES;
- 应用内不同语言环境的切换
	- 实现方案：定义指向对应语言目录路径的NSBundle实例，切换语言则重新创建；
- Xib和Storyboard的国际化
	- 编辑文本UI时，使用脚本重新生成.strings文件，如果直接使用Xcode工具会把原来配置好的语言给替换掉；
- BWLanguageManager
    - 语言管理类；

# 开发经验总结
- UI搭建
	- Storyboard感觉还是不够稳定，项目开发优先使用手写代码+Xib搭建界面的方式；
- 脚本
	- 脚本运行
		- Xcode - Run Script
		- Shell终端使用命令运行
	- 脚本的作用
    	- 便捷地对文件、代码进行修改，不用编译、运行才能使用，脚本是解析执行的；
    - 脚本语言
    	- shell
        - python
- 宏定义和在方法外定义常量的区别
	- 方法未定义的常量，给常量赋初值时不能包含方法，宏定义可以，宏定义原理是宏替换；
- 养成良好的开发习惯
	- 定期备份、及时备份的开发习惯；
- 调研
    - 贴上Reference资源；