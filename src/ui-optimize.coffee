# 注入自定义样式
injectStyle = ->
  
  styleId = 'isa-qzone-style';
  return if document.getElementById styleId

  style = document.createElement 'style'
  style.id = styleId

  style.setAttribute 'type', 'text/css'
  # 使用grunt替换
  style.innerText = @@$$STYLE_TEXT$$
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
  fw = top <= -1750
  rightSidebar.classList[ if fw then 'add' else 'remove'] 'cq-hide'
  mainFeed.classList[ if fw then 'add' else 'remove'] 'cq-fullwidth'
  return