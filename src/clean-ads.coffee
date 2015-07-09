
doc = document.body
# 页面content
pageContent = document.getElementById 'pageContent'
# 左侧分类导航栏
leftSidebar = doc.querySelector '.mod-side-nav-message'
# 右侧侧边栏
rightSidebar = doc.querySelector '.col-main-sidebar'
# 显示好友动态的区域
mainFeed = doc.querySelector '.col-main-feed'
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
  ads = doc.querySelectorAll adsSelector.join ','
  Array::forEach.call ads, removeSingleMoment
  return


# 移除单条广告动态
removeSingleMoment = (elem)->
  while elem
    if elem.classList.contains 'f-single'
      console.log 'remove ads(NO.' + (++adscount) +  '): ' + elem.innerText
      if elem.parentElement then elem.parentElement.removeChild elem
      elem = null
      return
    elem = elem.parentElement
  return

# // 监听动态展示区域的滚动事件
onMScroll = ->
  top = pageContent.getBoundingClientRect().top
  # 固定/取消固定侧边栏
  leftSidebar.classList[ if top <= 41 then 'add' else 'remove'] 'cq-fixed-sidebar'
  if top <= -1750
    rightSidebar.classList.add 'cq-hide'
    mainFeed.classList.add 'cq-fullwidth'
  else
    rightSidebar.classList.remove 'cq-hide'
    mainFeed.classList.remove 'cq-fullwidth'
  return

