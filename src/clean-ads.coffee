
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
