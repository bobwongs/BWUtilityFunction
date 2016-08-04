
# BWUtilityFunction

# 国际化
开发经验  

本地化文件原理
    在相应目录下创建了对应的配置目录和文件，谨慎使用移动和更改文件目录的操作，如果需要使用，则对原来配置过本地化的文件再配置一次，会提醒是否需要用原来的文件，此时选择使用原来的文件就好了，同时也要注意文件备份才是比较保险的方法；
    国际化其实都大同小异，其核心思想就是为每种语言单独定义一份资源；
    iOS就是通过xxx.lproj目录来定义每个语言的资源，这里的资源可以是图片，文本，Storyboard，Xib等；
    项目源代码中如果有多个不同目录的国际化资源，则会有产生多个xxx.lproj，但在编译打包后，会集中放在app的根目录中的xxx.lproj中；
iOS App名字国际化
    添加一个StringFile，命名为InfoPlist.strings。并且在文件属性里将所需要的多国语言勾上；
    添加一条新的多语言记录，CFBundleDisplayName，并对其做多语言处理；
    在targets->info里面添加一条新的记录，Application has localized display name， 并将值设为YES；

# 开发经验
	Storyboard感觉还是不够稳定，项目开发优先使用手写代码+Xib搭建界面的方式；
    脚本
        脚本运行
            Xcode - Run Script
            Shell终端使用命令运行
        脚本的作用
            便捷地对文件、代码进行修改，不用编译、运行才能使用，脚本是解析执行的；
        脚本语言
            shell
            python