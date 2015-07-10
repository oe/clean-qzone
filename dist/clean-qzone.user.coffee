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

getParent = (elem, pClass)->
  while elem
    return elem if elem.classList.contains pClass
    elem = elem.parentElement
  return
# 注入自定义样式
injectStyle = ->
  
  styleId = 'isa-qzone-style';
  return if document.getElementById styleId

  style = document.createElement 'style'
  style.id = styleId

  style.setAttribute 'type', 'text/css'
  # 使用grunt替换
  style.innerText = "[data-url^=\"http://c.gdt.qq.com\"],.gdtads_box,.ck-act,.icenter-right-ad,.fn_paipai,.mod-side-nav-recently-used,.hot-msg,.msg-channel-wrapper,.user-vip-info,.gb_ad_tearing_angle,.icon_app_new,.fn_accessLog_tips,.qz-app-flag,.icon-new-fun,.hotbar_wrap,.icon-red-dot,.sn-radio{display:none !important}.cq-fixed-sidebar{position:fixed;width:170px;top:41px}.cq-hide{display:none !important}.cq-fullwidth{-webkit-transition:width .3s linear;transition:width .3s linear;width:100% !important}.cq-fullwidth .img-box-row-wrap .img-box-row{display:inline !important}.cq-fullwidth .img-box-row-wrap .img-box-row+.img-box-row{margin-left:4px}.yosemite .background-container{background:none}.yosemite .mod-side-nav{box-shadow:0 0 1px rgba(0,0,0,0.07);background-color:#f9f9f9;border:1px solid #e9e9e9}"
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

# 移除所有在好友动态列表中植入的广告
removeDynamicMoments = ->
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


# 移除单条广告动态
removeSingleMoment = (elem)->
  if elem = getParent elem, 'f-single'
    console.log 'remove ads(NO.' + (++adscount) +  '): ' + elem.innerText
    if elem.parentElement then elem.parentElement.removeChild elem
    elem = null
  return


doRemoveDynamicMoments = ->
  deRemoveDynamicAds = debounce removeDynamicMoments

  do deRemoveDynamicAds
  document.getElementById('main_feed_container').addEventListener 'DOMSubtreeModified', deRemoveDynamicAds
  return

# 初始化
do ->
  # 不在个人主页则返回
  return unless document.querySelector '.mod-side-nav-message'

  do injectStyle
  do doRemoveDynamicMoments
  do doUXOpt

  return
