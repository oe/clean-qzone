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



# 插件数据存储
lstore =
  _storeKey: 'isa-cq-settings'
  kwdsKey: 'kwds'
  

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
    kwds = @getKwds @kwdsKey
    return false if kwd in kwds
    kwds.unshift kwd
    @set @kwdsKey, kwds
    true

  removeKwd: (kwd)->
    kwds = @getKwds @kwdsKey
    idx = kwds.indexOf kwd
    return unless ~idx
    kwds.splice idx, 1
    @set @kwdsKey, kwds

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
  style.innerText = ".cq-hide{display:none !important}.cq-yosemite-style-bg{-webkit-filter:blur(6px) saturate(2);background-size:cover}.cq-disabled{opacity:.6;cursor:default;pointer-events:none}.cq-input{border:1px solid #bfbfbf;border-radius:2px;box-sizing:border-box;color:#444;font:inherit;margin:0;padding:2px 6px;outline:none}.cq-input:focus{outline:none}.cq-btn{border:1px solid #cfcfcf;background:none;color:#666;text-align:center;border-radius:3px;line-height:26px;box-sizing:border-box;-webkit-appearance:none;-moz-appearance:none;appearance:none;padding:0 10px;margin:0;height:28px;white-space:nowrap;position:relative;overflow:hidden;text-overflow:ellipsis;font-size:14px;font-family:inherit;cursor:pointer;outline:none}.cq-btn:active{text-decoration:none;background:#f5f5f5}[data-url^=\"http://c.gdt.qq.com\"],.gdtads_box,.ck-act,.icenter-right-ad,.fn_paipai,.mod-side-nav-recently-used,.hot-msg,.msg-channel-wrapper,.user-vip-info,.gb_ad_tearing_angle,.icon_app_new,.fn_accessLog_tips,.qz-app-flag,.icon-new-fun,.hotbar_wrap,.icon-red-dot,.sn-radio,.user-home,.mall-sp-container{display:none !important}.cq-fixed-sidebar{position:fixed;width:170px;top:41px}.cq-fullwidth{-webkit-transition:width .3s linear;transition:width .3s linear;width:100% !important}.cq-fullwidth .img-box-row-wrap .img-box-row{display:inline !important}.cq-fullwidth .img-box-row-wrap .img-box-row+.img-box-row{margin-left:4px}.cq-yosemite .cq-bg{position:fixed;top:0;bottom:0;right:0;left:0;-webkit-filter:blur(6px) saturate(2);background-size:cover}.cq-yosemite .background-container{position:relative;background:none}.cq-yosemite .mod-side-nav{box-shadow:0 0 1px rgba(0,0,0,0.07);background-color:#f9f9f9;border:1px solid #e9e9e9}.cq-overlay{position:fixed;top:0;left:0;bottom:0;right:0;background-color:rgba(0,0,0,0.1)}.cq-settings-dialog{position:absolute;top:0;left:0;bottom:0;right:0;height:60%;width:60%;min-width:600px;max-width:700px;margin:auto;overflow:hidden;border:1px solid rgba(0,0,0,0.1);background-color:#f9f9f9;box-shadow:0 0 1px rgba(0,0,0,0.07);color:#333;border-radius:6px;font:14px/1.6 Tahoma,Geneva,'Simsun';box-sizing:border-box}.cq-sidemenu{position:absolute;left:0;top:0;width:20%;height:100%}.cq-sidemenu .title{padding:10px 6px;color:#08c;font-weight:bold;text-align:center}.cq-sidemenu .cq-menus{list-style:none;padding:0;color:#999;margin:10px 6px 0 0}.cq-sidemenu .cq-menus>li{box-sizing:border-box;padding:4px 8px;border-left:4px solid transparent;cursor:pointer}.cq-sidemenu .cq-menus>li.active{color:#666;border-left-color:#999;cursor:default;pointer-events:none}.cq-settings-close{position:absolute;top:6px;right:6px;font-size:3em;width:20px;height:20px}.cq-settings-close:after,.cq-settings-close:before{position:absolute;left:9px;content:' ';width:3px;height:100%;background-color:#ccc;-webkit-transition:all .2s linear;transition:all .2s linear}.cq-settings-close:after{-webkit-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg)}.cq-settings-close:before{-webkit-transform:rotate(-45deg);-ms-transform:rotate(-45deg);transform:rotate(-45deg)}.cq-settings-close:hover:after,.cq-settings-close:hover:before{background-color:#555}.cq-setting-wrapper{width:80%;margin-left:20%;padding:8px 14px 8px 0;box-sizing:border-box;height:100%;overflow:hidden;overflow-y:auto}.cq-setting-content{display:none}.cq-setting-content.active{display:block}.cq-setting-content .title{font-size:1.2em;padding:8px;border-bottom:1px solid #ccc;margin-bottom:10px}.cq-setting-content .title>small{color:#777;font-size:.8em;margin-left:8px}.cq-input-wrapper{margin-bottom:10px}.cq-kwds{list-style:none;padding:0;margin:0;color:#888;font-size:.8em}.cq-kwds>li{display:inline-block;margin-right:4px;border:1px solid #ddd;padding:3px 12px;border-radius:16px;margin-bottom:6px;cursor:default}.cq-kwds>li>.close{margin-left:2px;font-size:1.2em;cursor:pointer}.cq-kwds>li>.close:after{content:'×'}.cq-kwds>li:hover{box-shadow:0 2px 2px #ccc}.cq-kwds>li:hover>.close{color:#333}.cq-themes{list-style:none;padding:0;margin:0}.cq-themes>li{position:relative;display:inline-block;margin-right:1em;border-radius:6px;border:1px solid #ddd;width:46%;padding-bottom:23%;margin-bottom:6px;cursor:pointer;vertical-align:middle;overflow:hidden}.cq-themes>li>img{position:absolute;top:0;-webkit-filter:blur(6px) saturate(2);background-size:cover;max-width:100%;height:auto}.cq-themes>li.cq-selected{cursor:default;pointer-events:none}.cq-themes>li.cq-selected:before{position:absolute;top:0;left:0;bottom:0;right:0;content:' ';background-color:rgba(255,255,255,0.3);z-index:1}.cq-themes>li.cq-selected:after{content:'✓';font-size:2em;position:absolute;top:50%;left:50%;margin-top:-1em;margin-left:-0.5em;z-index:2}"
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
  try
    QZONE.music.qqplayer_play_flag = 0
    do QZONE.music.pauseMusic
  catch e


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


lstore.addKwd '莱特币'
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
  text = elem.innerText
  hasKwd = blockedKwds.some (kwd)-> ~text.indexOf kwd

  hasKwd and removeSingleMoment elem
  return


  

# 移除单条广告动态
removeSingleMoment = (elem)->
  if elem = getParent elem, 'f-single'
    if removeElement elem
      console.info '%cremove ads(NO.' + (++adscount) +  '): %c' + elem.innerText, 'color:#5d7895', 'color: #333'
    elem = null
  return


doRemoveDynamicMoments = ->
  deRemoveAds = debounce removeAds

  do deRemoveAds
  document.getElementById('main_feed_container').addEventListener 'DOMSubtreeModified', deRemoveAds
  return

# 扩展版本, 用来判断是否有更新
EXT_VERSION = "0.0.14"

# 检查是否有更新的回调处理
Global.checkCqUpdate = (versionInfo)->
  if EXT_VERSION isnt versionInfo.version and versionInfo.version isnt lstore.get 'version'
    versionInfo.oldVersion = EXT_VERSION
    showExtUpdateAlert versionInfo
    lstore.get 'version', versionInfo.version
    return

# 插入script 检查更新
checkUpdate = ->
  script = document.createElement 'script'
  script.src = "https://cdn.rawgit.com/evecalm/clean-qzone/master/dist/clean-qzone.check-update.js"
  script.type = 'text/javascript'
  document.body.appendChild script
  return
  
# 初始化
do ->
  do injectStyle
  # 不在个人主页则返回
  return unless document.querySelector '.mod-side-nav-message'
  do doRemoveDynamicMoments
  do doUXOpt

  do checkUpdate
  return
