# 初始化
do ->
  thOnscroll = throttle onMScroll, 200

  deRemoveDynamicAds = debounce removeDynamicMoments
  
  if !leftSidebar then return
  
  do injectStyle
  do deRemoveDynamicAds
  do thOnscroll

  window.addEventListener 'scroll', thOnscroll

  document.getElementById('main_feed_container').addEventListener 'DOMSubtreeModified', deRemoveDynamicAds
  return

