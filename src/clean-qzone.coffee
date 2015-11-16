# 扩展版本, 用来判断是否有更新
EXT_VERSION = @@$$VERSION$$

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
  script.src = @@$$UPDATE_CHECK_URL$$
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
