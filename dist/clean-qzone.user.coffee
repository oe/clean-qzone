###*
 * create a fn that will delay to exec util wait milliseconds has passed
 *     since last time invoked
 * @param  {Function} fn      fn to exec
 * @param  {Object}   context fn's exec context
 * @param  {Number}   wait    time to wait, millisecond
 * @return {Function}           a new fn
###
debounce = (fn, context, wait)->
  tid = null
  wait = 200 if isNaN(wait) or wait < 0
  # if content is a number, assign it to wait
  if not isNaN context
    wait = context if context > 0
    context = undefined
  ->
    clearTimeout tid
    tid = setTimeout ->
      fn?.call context
      return
    , wait
    return

###*
 * create a new function that will exec every wait milliseconds even when
 *     it frequently invoked
 * @param  {Function} fn      fn to exec
 * @param  {Object}   context fn's exec context
 * @param  {Number}   wait    time to wait, milisecond
 * @return {Function}           a new function
###
throttle = (fn, context, wait)->

  last = false
  tid = null
  wait = 200 if isNaN(wait) or wait < 0
  # if content is a number, assign it to wait
  if not isNaN context
    wait = +context if context > 0
    context = undefined
  ->
    now = + new Date()
    last = now if last is false
    remain = wait - (now - last)
    clearTimeout tid
    if remain <= 0
      fn?.call context
      wait = false
    else
      tid = setTimeout ->
        fn?.call context
        return
      , remain
    return

# get parent element that has class pClass
getParent = (elem, pClass)->
  while elem
    return elem if elem.classList.contains pClass
    elem = elem.parentElement
  return

# remove element from DOM tree
removeElement = (elem)->
  if elem and elem.parentElement
    elem.parentElement.removeChild elem
    true
  else
    false

# 转义HTML实体
encodeHtml = (str)->
  String(str)
  .replace /&/g, '&amp;'
  .replace /</g, '&lt;'
  .replace />/g, '&gt;'
  .replace /"/g, '&quot;'


# 插件数据存储
lstore =
  _storeKey: 'isa-cq-settings'
  kwdsKey: 'kwds'
  bgimgsKey: 'bgimg-list'

  set: (key, val)->
    @_data[ key ] = val
    do @save

  get: (key)->
    @_data[ key ]

  save: ->
    localStorage.setItem @_storeKey, JSON.stringify @_data

  getKwds: ->
    kwds = @get @kwdsKey
    kwds ?= []
    kwds

  addKwd: (kwd)->
    kwds = do @getKwds
    return false if kwd in kwds
    kwds.unshift kwd
    @set @kwdsKey, kwds
    true

  removeKwd: (kwd)->
    kwds = do @getKwds
    idx = kwds.indexOf kwd
    return false unless ~idx
    kwds.splice idx, 1
    @set @kwdsKey, kwds
    true

  getBgimgs: ->
    bgimgs = @get @bgimgsKey
    bgimgs ?= []
    bgimgs

  removeBgimg: (url)->
    bgimgs = do @getBgimgs
    idx = bgimgs.indexOf url
    return false unless ~idx
    bgimgs.splice idx, 1
    @set @bgimgsKey, bgimgs
    return true

  addBgimg: (url)->
    bgimgs = do @getBgimgs
    return false if url in bgimgs
    bgimgs.unshift url
    @set @bgimgsKey, bgimgs
    true

lstore._data = do ->
  d = localStorage.getItem lstore._storeKey
  JSON.parse d or '{}'
# 注入自定义样式
injectStyle = ->

  styleId = 'isa-qzone-style'
  return if document.getElementById styleId

  style = document.createElement 'style'
  style.id = styleId

  style.setAttribute 'type', 'text/css'
  # 使用grunt替换
  style.textContent = ".cq-hide{display:none !important}.cq-yosemite-style-bg{-webkit-filter:blur(6px) saturate(2);background-size:cover}.cq-disabled{opacity:.6;cursor:default;pointer-events:none}.cq-input{border:1px solid #bfbfbf;border-radius:2px;box-sizing:border-box;color:#444;font:inherit;margin:0;padding:2px 6px;outline:none}.cq-input:focus{outline:none}.cq-btn{border:1px solid #cfcfcf;background:none;color:#666;text-align:center;border-radius:3px;line-height:26px;box-sizing:border-box;-webkit-appearance:none;-moz-appearance:none;appearance:none;padding:0 10px;margin:0;height:28px;white-space:nowrap;position:relative;overflow:hidden;text-overflow:ellipsis;font-size:14px;font-family:inherit;cursor:pointer;outline:none}.cq-btn:active{text-decoration:none;background:#f5f5f5}[data-url^=\"http://c.gdt.qq.com\"],.gdtads_box,.ck-act,.icenter-right-ad,.fn_paipai,.mod-side-nav-recently-used,.hot-msg,.msg-channel-wrapper,.user-vip-info,.gb_ad_tearing_angle,.icon_app_new,.fn_accessLog_tips,.qz-app-flag,.icon-new-fun,.hotbar_wrap,.icon-red-dot,.sn-radio,.user-home,.mall-sp-container,#js-qq-ad{display:none !important}.cq-remove-qzvip .vip-setting,.cq-remove-qzvip .qz-f-vip-l-y,.cq-remove-qzvip .qz-f-vip-l,.cq-remove-qzvip .detail-info-level,.cq-remove-qzvip #divGif4Visitor{display:none !important}.cq-fixed-sidebar{position:fixed;width:170px;top:41px}.cq-fullwidth{transition:width .3s linear;width:100% !important}.cq-fullwidth .img-box-row-wrap .img-box-row{display:inline !important}.cq-fullwidth .img-box-row-wrap .img-box-row+.img-box-row{margin-left:4px}.top-fix-inner{z-index:1010 !important}.cq-bg{display:none;transition:all .5s ease-out}.cq-yosemite .cq-bg{display:block;position:fixed;top:0;bottom:0;right:0;left:0;-webkit-filter:blur(6px) saturate(2);background-size:cover}.cq-yosemite .background-container{position:relative;background:none}.cq-yosemite .mod-side-nav{box-shadow:0 0 1px rgba(0,0,0,0.07);background-color:#f9f9f9;border:1px solid #e9e9e9}.cq-overlay{display:none;position:fixed;top:0;left:0;bottom:0;right:0;background-color:rgba(0,0,0,0.3);z-index:99999}.cq-show-setting-dlg{overflow:hidden !important}.cq-show-setting-dlg .cq-overlay{display:block}.cq-settings-dialog{position:absolute;top:0;left:0;bottom:0;right:0;height:60%;width:60%;min-width:600px;max-width:700px;margin:auto;overflow:hidden;border:1px solid rgba(0,0,0,0.1);background-color:#f9f9f9;box-shadow:0 0 1px rgba(0,0,0,0.07);color:#333;border-radius:6px;font:14px/1.6 Tahoma,Geneva,'Simsun';box-sizing:border-box}.cq-sidemenu{position:absolute;left:0;top:0;width:20%;height:100%}.cq-sidemenu .title{padding:10px 6px;color:#08c;font-weight:bold;text-align:center}.cq-sidemenu .cq-menus{list-style:none;padding:0;margin:0;color:#999}.cq-sidemenu .cq-menus>li{box-sizing:border-box;padding:4px 8px;border-left:4px solid transparent;cursor:pointer}.cq-sidemenu .cq-menus>li.active{color:#666;border-left-color:#999;cursor:default;pointer-events:none}.cq-settings-close{position:absolute;top:6px;right:6px;width:2em;height:2em}.cq-settings-close:after,.cq-settings-close:before{position:absolute;left:9px;content:' ';width:3px;height:100%;background-color:#ccc;transition:all .2s linear}.cq-settings-close:after{-webkit-transform:rotate(45deg);transform:rotate(45deg)}.cq-settings-close:before{-webkit-transform:rotate(-45deg);transform:rotate(-45deg)}.cq-settings-close:hover:after,.cq-settings-close:hover:before{background-color:#555}.cq-setting-wrapper{width:80%;margin-left:20%;padding:8px 14px 8px 0;box-sizing:border-box;height:100%;overflow:hidden;overflow-y:auto}.cq-setting-content{display:none}.cq-setting-content.active{display:block}.cq-setting-content .title{font-size:1.2em;padding:8px;border-bottom:1px solid #ccc;margin-bottom:10px}.cq-setting-content .title>small{color:#777;font-size:.8em;margin-left:8px}.cq-input-wrapper{margin-bottom:10px}.cq-kwds{list-style:none;padding:0;margin:0;color:#888;font-size:.8em}.cq-kwds>li{display:inline-block;margin-right:4px;border:1px solid #ddd;padding:3px 12px;border-radius:16px;margin-bottom:6px;cursor:default}.cq-kwds>li>.close{margin-left:2px;font-size:1.2em;cursor:pointer}.cq-kwds>li>.close:after{content:'×'}.cq-kwds>li:hover{box-shadow:0 2px 2px #ccc}.cq-kwds>li:hover>.close{color:#333}#cq-theme-choose-wrapper{margin-top:8px;opacity:.6;cursor:default;pointer-events:none;transition:opacity .2s ease-in}#cq-theme-ckbx:checked~#cq-theme-choose-wrapper{opacity:1;cursor:auto;pointer-events:auto}#cq-theme-ckbx:checked~#cq-theme-choose-wrapper .cq-close{display:block}.cq-themes{list-style:none;padding:0;margin:0}.cq-themes>li{position:relative;display:inline-block;margin-right:1em;border-radius:6px;border:1px solid #ddd;width:46%;padding-bottom:23%;margin-bottom:6px;cursor:pointer;vertical-align:middle;overflow:hidden}.cq-themes>li>.cq-close{font-size:.6em;display:none;position:absolute;top:6px;right:6px;width:2em;height:2em;z-index:2}.cq-themes>li>.cq-close:after,.cq-themes>li>.cq-close:before{position:absolute;left:9px;content:' ';width:3px;height:100%;background-color:#ccc;transition:all .2s linear}.cq-themes>li>.cq-close:after{-webkit-transform:rotate(45deg);transform:rotate(45deg)}.cq-themes>li>.cq-close:before{-webkit-transform:rotate(-45deg);transform:rotate(-45deg)}.cq-themes>li>.cq-close:hover:after,.cq-themes>li>.cq-close:hover:before{background-color:#555}.cq-themes>li>img{position:absolute;top:0;-webkit-filter:blur(6px) saturate(2);background-size:cover;max-width:100%;height:auto}.cq-themes>li.cq-selected{cursor:default;pointer-events:none}.cq-themes>li.cq-selected>.cq-close{display:none !important}.cq-themes>li.cq-selected:before{position:absolute;top:0;left:0;bottom:0;right:0;content:' ';background-color:rgba(255,255,255,0.3);z-index:1}.cq-themes>li.cq-selected:after{content:'✓';font-size:2em;position:absolute;top:50%;left:50%;margin-top:-1em;margin-left:-0.5em;z-index:2}.js-enable-ibgm{opacity:.6;cursor:default;pointer-events:none;transition:opacity .2s ease-in}#cq-disable-bgm-ckbx:checked~.js-enable-ibgm{opacity:1;cursor:auto;pointer-events:auto}.cq-update-dialog{position:fixed;top:50px;right:10px;padding:8px;color:#8a6d3b;background-color:#fcf8e3;border:1px solid #faebcc;font-size:.9em;max-width:300px;border-radius:4px;word-break:break-all;word-wrap:break-word;box-shadow:0 3px 10px rgba(0,0,0,0.3);z-index:9998}.cq-update-dialog .cq-title{text-align:center;color:#555;font-size:1.1em}.cq-update-dialog .cq-update-actions a{margin-right:20px}"
  document.head.appendChild style

  return


# 页面content
pageContent = document.getElementById 'pageContent'
# 左侧分类导航栏
leftSidebar = document.querySelector '.mod-side-nav-message'
# 右侧侧边栏
rightSidebar = document.querySelector '.col-main-sidebar'
# 显示好友动态的区域
mainFeed = document.querySelector '.col-main-feed'


# 监听动态展示区域的滚动事件
onMScroll = ->
  top = pageContent.getBoundingClientRect().top
  # 固定/取消固定左侧侧边栏
  leftSidebar.classList[ if top <= 41 then 'add' else 'remove'] 'cq-fixed-sidebar'
  # 动态展示区域是否可以以100%宽度展示
  action = if top <= -1750 then 'add' else 'remove'
  rightSidebar.classList[ action ] 'cq-hide'
  mainFeed.classList[ action ] 'cq-fullwidth'
  return

# meta + enter to post a comment
onKeyPress = (e)->
  if e.metaKey and e.keyCode is 13 and (elem = getParent e.target, 'qz-poster-inner')
    btn = elem.querySelector '.btn-post'
    btn?.click()
  return

# 禁止自动播放背景音乐
stopBgMusic = ->
  oldFn = QZONE.frontPageAccessory.musicPlayer.bootstrap
  QZONE.frontPageAccessory.musicPlayer.bootstrap = ->
    oldFn.apply QZONE.frontPageAccessory.musicPlayer.bootstrap, arguments
    QZONE.music.qqplayer_play_flag = 0
    do QZONE.music.pauseMusic
    debugger
    console.log 'stop music'
    return
  return

doUXOpt = ->
  thOnscroll = throttle onMScroll
  do thOnscroll
  window.addEventListener 'scroll', thOnscroll

  # 值针对OSX做输入框的快捷键处理
  return unless ~navigator.userAgent.indexOf 'OS X'
  pageContent.addEventListener 'keydown', (e)->
    if e.target.classList.contains 'textarea' then onKeyPress e
    return
  , true
  return


# 广告计数
adscount = 0


# lstore.addKwd '莱特币'
# 全局保存kwds, 避免每次读取
blockedKwds = []

removeAds = ->
  do removeOfficalMoments
  do removeKwdMoments
  return

# 删除所有官方注入的广告
removeOfficalMoments = ->
  adsSelector = [
    # 应用游戏推广
    '.votestar'
    # 购物推广
    '.buy-info'
    # 游戏推广
    '.f-single-biz'
    # QQ空间官方强制推广
    '[href="http://user.qzone.qq.com/20050606"]'
  ]
  ads = document.querySelectorAll adsSelector.join ','
  Array::forEach.call ads, removeSingleMoment
  return

# 删除所有关键字广告
removeKwdMoments = ->
  # 每次调用前更新kwds列表
  blockedKwds = do lstore.getKwds
  return unless blockedKwds and blockedKwds.length
  momentsSelector = [
    # 用户发布的内容
    '.f-info'
    # 用户分享的内容
    '.f-ct'
  ]
  moments = document.querySelectorAll momentsSelector.join ','
  Array::forEach.call moments, removeKwdMoment
  return

# 删除单条关键节广告
removeKwdMoment = (elem)->
  text = elem.textContent
  hasKwd = blockedKwds.some (kwd)-> ~text.indexOf kwd

  hasKwd and removeSingleMoment elem
  return




# 移除单条广告动态
removeSingleMoment = (elem)->
  if elem = getParent elem, 'f-single'
    if removeElement elem
      console.info '%cremove ads(NO.' + (++adscount) +  '): %c' + elem.textContent, 'color:#5d7895', 'color: #333'
    elem = null
  return

# 广告初始化
doRemoveDynamicMoments = ->
  deRemoveAds = debounce removeAds

  do deRemoveAds
  document.getElementById('main_feed_container').addEventListener 'DOMSubtreeModified', deRemoveAds
  return

# 显示版本更新信息
showExtUpdateAlert = (info)->
  html = '<div class="cq-update-dialog"> <div class="cq-title">Clean Qzone有更新</div> <div class="cq-version-info">官网版本' + info.version + '，当前使用的版本' + info.oldVersion + '</div> <div class="cq-update-detail"><strong>更新详情</strong>: ' + info.updateMsg + ' </div> <div class="cq-update-actions"><a href="https://github.com/evecalm/clean-qzone#更新" target="_blank">去更新</a> <a href="javascript:;">知道鸟</a></div>'
  div = document.createElement 'div'
  div.innerHTML = html
  div = div.firstElementChild
  div.addEventListener 'click', (e)->
    if e.target.tagName.toLowerCase() is 'a'
      div.classList.add 'cq-hide'
    return
  document.body.appendChild div
  console.log 'show alert infoooooo'
  return

# 显示/隐藏设置对话
toggleSettingDlg = (isShow)->
  document.documentElement.classList[if isShow then 'add' else 'remove'] 'cq-show-setting-dlg'
  if isShow then do onSettingDlgShow
  return

# 对话框显示时的操作
onSettingDlgShow = ->
  do refreshKwdsList
  return

# 获取设置面板
getSettingPanel = ->
  return getSettingPanel.wp if getSettingPanel.wp
  html = '''
  <div class="cq-settings-dialog">
    <div class="cq-settings-close"></div>
    <div class="cq-sidemenu">
      <div class="title">
         Clean Qzone
      </div>
      <ul class="cq-menus" id="cq-settings-menus">
        <li class="active" data-target="cq-setting-kwds">屏蔽关键字</li>
        <li data-target="cq-setting-theme">主题设置</li>
        <li data-target="cq-setting-others">其他</li>
      </ul>
    </div>
    <div class="cq-setting-wrapper" id="cq-setting-wrapper">
      <div class="cq-setting-content active" id="cq-setting-kwds">
        <div class="title">屏蔽关键字 <small>屏蔽含有关键字的动态</small></div>
        <div class="cq-input-wrapper">
          <label>添加关键字 <input type="text" class="cq-input" id="cq-kwd-input"></label> <button class="cq-btn" id="cq-kwd-add-btn">添加</button>
        </div>
        <ul class="cq-kwds" id="cq-kwds-list">
        </ul>
      </div>

      <div class="cq-setting-content" id="cq-setting-theme">
        <div class="title">主题设置 <small>使用 OS X Yosemite风格主题</small></div>
        <input type="checkbox" id="cq-theme-ckbx"><label for="cq-theme-ckbx"> 启用 Yosemite 主题, 高大上!</label>
        <div class="cq-theme-choose-wrapper" id="cq-theme-choose-wrapper">
          <div class="cq-input-wrapper">
            选择下列背景图, 或者自定义图片URL
            <input type="text" class="cq-input" id="cq-themeurl-input"> <button class="cq-btn" id="cq-theme-add-btn">设置</button>
          </div>
          <ul class="cq-themes" id="cq-themes-list">
            <li><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2014/09/10/869135.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2014/09/15/876900.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2013/11/27/423205.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2013/09/25/389783.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2015/03/31/1131254.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2014/11/28/981054.jpg"></li>
          </ul>
        </div>
      </div>
      <div id="cq-setting-others" class="cq-setting-content">
        <div class="title">其他设置 <small><a href="https://github.com/evecalm/clean-qzone/issues/new" target="_blank">有其他功能建议?</a></small></div>
        <!--
        <div class="cq-input-wrapper">
          <input type="checkbox" id="cq-disable-bgm-ckbx">
          <label for="cq-disable-bgm-ckbx">禁止自动播放背景音乐</label>
          <label class="cq-label js-enable-ibgm">
            <input type="checkbox" id="cq-enable-ibgm-ckbx"> 只允许我的空间自动播放背景音乐
          </label>
        </div>
        -->
        <div class="cq-input-wrapper">
          <label><input type="checkbox" id="cq-disable-qvip-ckbx"> 移除所有黄钻相关的logo/菜单/推广</label>
        </div>
      </div>
    </div>
  </div>
  '''
  getSettingPanel.wp = document.createElement 'div'
  getSettingPanel.wp.classList.add 'cq-overlay'
  # getSettingPanel.wp.classList.add 'cq-hide'
  getSettingPanel.wp.innerHTML = html
  document.body.appendChild getSettingPanel.wp
  getSettingPanel.wp

attachSettingPanelEvents = ->
  # 左侧菜单列表
  document.getElementById('cq-settings-menus').addEventListener 'click', onMenuItemClick
  # 添加关键字按钮
  document.getElementById('cq-kwd-add-btn').addEventListener 'click', onAddKwdBtn
  # 删除关键字
  document.getElementById('cq-kwds-list').addEventListener 'click', onRemoveKwd
  # 启用主题
  document.getElementById('cq-theme-ckbx').addEventListener 'change', onSwitchTheme
  # 添加主题
  document.getElementById('cq-theme-add-btn').addEventListener 'click', onAddThemeClick
  # 选择主题
  document.getElementById('cq-themes-list').addEventListener 'click', onThemeClick
  # 关闭对话框
  document.querySelector('.cq-settings-close').addEventListener 'click', ->
    do toggleSettingDlg
  # 全局按escape键
  # 如对话框可见, 则隐藏, 并阻止事件冒泡, 避免暂停背景音乐
  document.addEventListener 'keydown', (e)->
    return if e.keyCode isnt 27 or e.target.tagName.toLowerCase() is 'input'
    if document.documentElement.classList.contains 'cq-show-setting-dlg'
      do toggleSettingDlg
      do e.stopPropagation
    return
  , true
  # 关键字输入框的键盘事件
  document.getElementById('cq-kwd-input').addEventListener 'keydown', (e)->
    # escape键
    if e.keyCode is 27
      do e.stopPropagation
      return
    # 回车键
    if e.keyCode is 13
      document.getElementById('cq-kwd-add-btn').click()
    return
  # 主题url输入框的键盘事件
  document.getElementById('cq-themeurl-input').addEventListener 'keydown', (e)->
    # escape键
    if e.keyCode is 27
      do e.stopPropagation
      return
    # 回车键
    if e.keyCode is 13
      document.getElementById('cq-theme-add-btn').click()
    return

  # 切换黄钻的开关
  document.getElementById('cq-disable-qvip-ckbx').addEventListener 'change', ->
    toggleAllVipLogo this.checked
    return

# 切换菜单激活状态
onMenuItemClick = (e)->
  elem = e.target
  return unless elem.tagName.toLowerCase() is 'li'
  return if elem.classList.contains 'active'

  now = this.querySelector '.active'
  if now then now.classList.remove 'active'
  elem.classList.add 'active'

  targetId = elem.getAttribute 'data-target'
  return unless targetId

  now = document.getElementById('cq-setting-wrapper').querySelector('.cq-setting-content.active')
  if now then now.classList.remove 'active'

  elem = document.getElementById targetId
  if elem then elem.classList.add 'active'
  return

# 添加关键字
onAddKwdBtn = (e)->
  ipt = document.getElementById 'cq-kwd-input'
  v = ipt.value.trim()
  return unless v
  if lstore.addKwd v
    prependKwd v
    ipt.value = ''
  else
    console.log '关键字已存在'
  return

# 追加关键字
prependKwd  = (v)->
  li = document.createElement 'li'
  li.innerHTML = "#{encodeHtml(v)}<span class='close'></span>"
  list = document.getElementById 'cq-kwds-list'
  list.insertBefore li, list.firstElementChild
  return

# 删除关键字
onRemoveKwd = (e)->
  target = e.target
  return unless target.tagName.toLowerCase() is 'span' and target.classList.contains 'close'
  li = target.parentElement

  kwd = li.textContent.trim()
  lstore.removeKwd kwd
  removeElement li
  return


# 刷新关键字列表
refreshKwdsList = ->
  kwds = do lstore.getKwds
  html = kwds.reduce (prev, kwd)->
    prev + "<li>#{encodeHtml(kwd)}<span class='close'></span></li>"
  , ''
  document.getElementById('cq-kwds-list').innerHTML = html
  return

# 启用/禁用样式
onSwitchTheme = ->
  enabled = this.checked
  toggleTheme enabled
  if enabled then do resetTheme
  
  return

# 切换主题显示效果
toggleTheme = (enabled)->
  enabled = !!enabled
  document.documentElement.classList[if enabled then 'add' else 'remove'] 'cq-yosemite'
  lstore.set 'yosemite-theme', enabled
  return

# 重置背景
resetTheme = ->
  themeList = document.getElementById 'cq-themes-list'
  selectedTheme = themeList.querySelector('.cq-selected') or themeList.firstElementChild
  return unless selectedTheme
  selectedTheme.classList.add 'cq-selected'
  updateBgImg selectedTheme.querySelector('img').src
  return

# 加载图片
loadImg = (url, done, fail)->
  img = new Image
  img.onload = done if done
  img.onerror = fail if fail
  img.src = url
  return
# 添加主题
onAddThemeClick = ->
  return unless url = document.getElementById('cq-themeurl-input').value
  loadImg url, -> prependTheme url
  return

# 添加主题
prependTheme = (url)->
  unless lstore.addBgimg url
    # 图片已存在
    return
  document.getElementById('cq-themeurl-input').value = ''

  li = document.createElement 'li'
  li.innerHTML = '<span class="cq-close"></span><img src="' + url + '">'
  themeList = document.getElementById 'cq-themes-list'
  themeList.insertBefore li, themeList.firstElementChild
  # 选中新增的主题
  do li.querySelector('img').click
  return

# 初始化主题列表
initThemeList = ->
  bgimgs = do lstore.getBgimgs
  frg = document.createDocumentFragment()
  bgimgs.forEach (bgimg)->
    li = document.createElement 'li'
    li.innerHTML = '<span class="cq-close"></span><img src="' + bgimg + '">'
    frg.appendChild li
    return
  
  themeList = document.getElementById 'cq-themes-list'
  themeList.insertBefore frg, themeList.firstElementChild
  
  if (bgImgUrl = lstore.get 'bgimg') and (img = themeList.querySelector '[src="' + bgImgUrl + '"]')
    img.parentElement.classList.add 'cq-selected'
    
  return

# 选择主题
onThemeClick = (e)->
  target = e.target
  li = target.parentElement
  # 切换主题
  if target.tagName.toLowerCase() is 'img'
    return if li.classList.contains 'cq-selected'
    this.querySelector('.cq-selected')?.classList.remove 'cq-selected'
    li.classList.add 'cq-selected'
    updateBgImg target.src
  else if target.classList.contains 'cq-close'
    lstore.removeBgimg li.querySelector('img').src
    removeElement li
  return

# 更新背景图片
updateBgImg = (url)->
  unless updateBgImg.wp and url
    updateBgImg.wp = document.createElement 'div'
    updateBgImg.wp.classList.add 'cq-bg'
    document.body.insertBefore updateBgImg.wp, document.body.firstElementChild
  updateBgImg.wp.style.backgroundImage = "url(#{url})"
  lstore.set 'bgimg', url
  return

# 向QQ空间的菜单中追加clean qzone的菜单
addSettingMenu = ->
  return unless menus = document.querySelector '#tb_setting_panel .drop-down-setting'
  menu = document.createElement 'a'
  menu.href = 'javascript:;'
  menu.textContent = 'Clean Qzone'
  menu.addEventListener 'click', ->
    toggleSettingDlg true
    return
  menus.insertBefore menu, menus.firstElementChild
  return

# 显示或隐藏黄钻相关的logo
toggleAllVipLogo = (isRemove)->
  isRemove = !!isRemove
  document.documentElement.classList[if isRemove then 'add' else 'remove'] 'cq-remove-qzvip'
  lstore.set 'disable-all-vip-logo', isRemove
  return

initSettingPanel = ->
  do getSettingPanel
  do addSettingMenu
  do attachSettingPanelEvents
  do initThemeList

  # 显示/隐藏黄钻相关标志
  if lstore.get 'disable-all-vip-logo'
    toggleAllVipLogo true
    document.getElementById('cq-disable-qvip-ckbx').checked = true
    
  # 启用yosemite主题
  enableTheme = lstore.get 'yosemite-theme'
  if enableTheme and (bgImgUrl = lstore.get 'bgimg')
    document.getElementById('cq-theme-ckbx').checked = true
    toggleTheme enableTheme
    updateBgImg bgImgUrl
  return
  
# 扩展版本, 用来判断是否有更新
EXT_VERSION = "0.1.11"

# 比较版本号，判断是否有更新
compareVersion = (onlineVer)->
  localVer = EXT_VERSION.split '.'
  onlineVer = onlineVer.split '.'
  i = 0
  while i < 3
    return true if +localVer[i] < +onlineVer[i]
    ++i
  return false
  


# 检查是否有更新的回调处理
Global.checkCqUpdate = (versionInfo)->
  if compareVersion(versionInfo.version) and versionInfo.version isnt lstore.get 'version'
    versionInfo.oldVersion = EXT_VERSION
    showExtUpdateAlert versionInfo
    lstore.set 'version', versionInfo.version
    return

# 插入script 检查更新
checkUpdate = ->
  script = document.createElement 'script'
  script.src = "https://http://app.evecalm.com/clean-qzone/dist/clean-qzone.check-update.js"
  document.body.appendChild script
  return

# 初始化
do ->
  do injectStyle
  # 不在个人主页则返回
  return unless document.querySelector '.mod-side-nav-message'
  do doRemoveDynamicMoments
  do doUXOpt
  # do stopBgMusic
  do checkUpdate
  do initSettingPanel

  return
