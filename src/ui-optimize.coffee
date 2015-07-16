# 注入自定义样式
injectStyle = ->

  styleId = 'isa-qzone-style'
  return if document.getElementById styleId

  style = document.createElement 'style'
  style.id = styleId

  style.setAttribute 'type', 'text/css'
  # 使用grunt替换
  style.textContent = @@$$STYLE_TEXT$$
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
