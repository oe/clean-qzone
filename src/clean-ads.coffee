
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
