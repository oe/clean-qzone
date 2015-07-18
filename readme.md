# Clean Qzone

Remove all Qzone ads, make your Qzone center clean and clear.

* 清理QQ空间各种相亲、购物、广点通、黄钻推广、弹窗、游戏推广等广告, 移除各种每次都会出现的小红点, 移除所有与社交无关的东西, 一个脚本治疗QQ空间各种不服! 强迫症福音!
* UI及交互优化
  * 滚动时固定左侧导航栏, 隐藏右侧侧边栏以增大动态展示区域
  * 为OS X用户增加 `⌘` + `enter` 发送评论的快捷键
  * 修正QQ空间右上角的设置菜单可能会被遮挡的bug(QQ空间自身bug)
* 支持使用关键字来屏蔽动态

## 安装/更新
1. 首先, 你得使用google chrome浏览器, 国内双核浏览器未经测试, 可能无法正常运行
2. [下载脚本](https://raw.githubusercontent.com/evecalm/clean-qzone/master/dist/clean-qzone.user.js), 脚本下载完成后浏览器顶部会有黄色警告提示, 请忽略之
3. 打开chrome的扩展管理页, 如果不知道怎么打开, 可以在浏览器地址栏直接输入 `chrome://extensions/` 再回车
4. 将下载的脚本拖入该页面, 在弹出对话框中点击确定. 如提示安全balabala, 不让安装, 勾选右上角的`开发者模式`(Developer mode)后重试
5. 再次打开QQ空间, 效果立现!

更新脚本请重复以上步骤

## 使用/配置
在QQ空间的个人主页, 将鼠标光标 **悬浮** 至右上角的设置图标(齿轮形状), 点击 *Clean Qzone* 即可打开脚本的设置面板


## bugs & advices
使用中如遇问题, 欢迎 [提交issue](https://github.com/evecalm/clean-qzone/issues/new)

## TODO
* [ ] 修复QQ空间背景音乐无法正常获取时, QQ空间自己的代码走入死循环导致浏览器内存使用量急剧上升的bug
* [ ] 美化QQ空间样式, 待设计, 想修改成OS X yosemite的风格. 如果有设计师想设计, 请 [提交issue](https://github.com/evecalm/clean-qzone/issues/new) 联系我
* [ ] 禁止QQ空间自动播放背景音乐

