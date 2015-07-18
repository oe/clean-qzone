# 扩展版本, 用来判断是否有更新
EXT_VERSION = @@$$VERSION$$

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
  script.src = @@$$UPDATE_CHECK_URL$$
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
  # do stopBgMusic
  do checkUpdate
  do initSettingPanel
  
  return
