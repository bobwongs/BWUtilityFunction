
# BWUtilityFunction

# 国际化
开发经验  
通过一个Localizable.strings文件来存储每个语言的文本，它是iOS默认加载的文件，如果想用自定义名称命名，在使用NSLocalizedString方法时指定tableName为自定义名称就好了，此宏定义方法有指定tableName来获得对应.strings文件中的语言文本，tableName即为.strings的文件名，但你的应用规模不是很大就不要分模块搞特殊了；
每一套语言新建一份strings，其内容采用"key" = "value";的格式，注意有;号；
strings【Localizable.strings(Simplified)】可以不要的(可以理解为中文为APP的默认语言)，因为key就是value，当找不到相应的语言strings或value时会直接返回key。nice！这样一来我们做文本的国际化就只要维护一个英文副本strings就O了；

# 开发经验
	Storyboard感觉还是不够稳定，项目开发优先使用手写代码+Xib搭建界面的方式；