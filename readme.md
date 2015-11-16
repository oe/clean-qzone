# Clean Qzone

Remove all Qzone ads, make your Qzone center clean and clear.

* 清理QQ空间各种相亲、购物、广点通、黄钻推广、弹窗、游戏推广等广告, 移除各种每次都会出现的小红点, 移除所有与社交无关的东西, 一个脚本治疗QQ空间各种不服! 强迫症福音!
* UI及交互优化
  * 滚动时固定左侧导航栏, 隐藏右侧侧边栏以增大动态展示区域
  * 为OS X用户增加 `⌘` + `enter` 发送评论的快捷键
  * 修正QQ空间右上角的设置菜单可能会被遮挡的bug(QQ空间自身bug)
* 支持使用关键字来屏蔽动态

## 安装/更新
### 常规安装
1. 首先, 你得使用[Google Chrome](https://www.google.com/chrome/)或者[Firefox](https://www.mozilla.org/firefox/), 国内双核浏览器未经测试, 可能无法正常运行
2. 安装 *用户脚本管理扩展*，Chrome用户请安装[Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?utm_source=chrome-ntp-icon)，Firefox用户请安装[Greasemonkey](https://addons.mozilla.org/firefox/addon/greasemonkey/)
3. 点击[安装脚本](http://app.evecalm.com/clean-qzone/dist/clean-qzone.user.js), 用户脚本管理扩展会提示安装，确认即可
4. 再次打开QQ空间, 效果立现!

### 非常规安装
如果使用OS X版或者Linux版的Chrome可以尝试不安装 *用户脚本管理扩展*  

1. 右击[下载脚本](http://app.evecalm.com/clean-qzone/dist/clean-qzone.user.js)选择 *保存链接为...* 保存脚本
2. 打开chrome扩展管理页面（也可以在浏览器地址栏直接输入 `chrome://extensions/` 再回车）
3. 将下载的脚本拖入该页面，幸运的话你会看到安装提示， 点击安装即可

因为Chrome的安全策略一直在变化，此种安装方法可能在新版本的chrome中失效，若失败则请使用[常规安装](#常规安装)

###更新
* 安装了 *用户脚本管理扩展*，正常会自动更新， 若没有，请点击[安装脚本](http://app.evecalm.com/clean-qzone/dist/clean-qzone.user.js)。
* 未安装 *用户脚本管理扩展* 的，再次[下载脚本](http://app.evecalm.com/clean-qzone/dist/clean-qzone.user.js)，再安装即可。

## 使用/配置
在QQ空间的个人主页, 将鼠标光标 **悬浮** 至右上角的设置图标(齿轮形状), 点击 *Clean Qzone* 即可打开脚本的设置面板


## bugs & advices
使用中如遇问题, 欢迎 [提交issue](https://github.com/evecalm/clean-qzone/issues/new)

## TODO
* [ ] 修复QQ空间背景音乐无法正常获取时, QQ空间自己的代码走入死循环导致浏览器内存使用量急剧上升的bug
* [ ] 美化QQ空间样式, 待设计, 想修改成OS X yosemite的风格. 如果有设计师想设计, 请 [提交issue](https://github.com/evecalm/clean-qzone/issues/new) 联系我
* [ ] 禁止QQ空间自动播放背景音乐

