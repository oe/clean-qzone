# 显示版本更新信息
showExtUpdateAlert = (info)->
  html = '<div class="cq-update-dialog"> <div class="cq-title">Clean Qzone有更新</div> <div class="cq-version-info">官网版本' + info.version + '，当前使用的版本' + info.oldVersion + '</div> <div class="cq-update-detail"><strong>更新详情</strong>: ' + info.updateMsg + ' </div> <div class="cq-update-actions"><a href="https://github.com/evecalm/clean-qzone#更新" target="_blank">去更新</a> <a href="javascript:;">知道鸟</a></div>'
  div = document.createElement 'div'
  div.innerHTML = html
  div = div.firstElementChild
  div.addEventListener 'click', (e)->
    if e.target.tagName.toLowerCase() is 'a'
      div.classList.add 'cq-hide'
    return
  document.body.appendChild div
  console.log 'show alert infoooooo'
  return

# 显示/隐藏设置对话
toggleSettingDlg = (isShow)->
  document.documentElement.classList[if isShow then 'add' else 'remove'] 'cq-show-setting-dlg'
  if isShow then do onSettingDlgShow
  return

# 对话框显示时的操作
onSettingDlgShow = ->
  do refreshKwdsList
  return

# 获取设置面板
getSettingPanel = ->
  return getSettingPanel.wp if getSettingPanel.wp
  html = '''
  <div class="cq-settings-dialog">
    <div class="cq-settings-close"></div>
    <div class="cq-sidemenu">
      <div class="title">
         Clean Qzone
      </div>
      <ul class="cq-menus" id="cq-settings-menus">
        <li class="active" data-target="cq-setting-kwds">屏蔽关键字</li>
        <li data-target="cq-setting-theme">主题设置</li>
        <li data-target="cq-setting-others">其他</li>
      </ul>
    </div>
    <div class="cq-setting-wrapper" id="cq-setting-wrapper">
      <div class="cq-setting-content active" id="cq-setting-kwds">
        <div class="title">屏蔽关键字 <small>屏蔽含有关键字的动态</small></div>
        <div class="cq-input-wrapper">
          <label>添加关键字 <input type="text" class="cq-input" id="cq-kwd-input"></label> <button class="cq-btn" id="cq-kwd-add-btn">添加</button>
        </div>
        <ul class="cq-kwds" id="cq-kwds-list">
        </ul>
      </div>

      <div class="cq-setting-content" id="cq-setting-theme">
        <div class="title">主题设置 <small>使用 OS X Yosemite风格主题</small></div>
        <input type="checkbox" id="cq-theme-ckbx"><label for="cq-theme-ckbx"> 启用 Yosemite 主题, 高大上!</label>
        <div class="cq-theme-choose-wrapper" id="cq-theme-choose-wrapper">
          <div class="cq-input-wrapper">
            选择下列背景图, 或者自定义图片URL
            <input type="text" class="cq-input" id="cq-themeurl-input"> <button class="cq-btn" id="cq-theme-add-btn">设置</button>
          </div>
          <ul class="cq-themes" id="cq-themes-list">
            <li><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2014/09/10/869135.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2014/09/15/876900.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2013/11/27/423205.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2013/09/25/389783.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2015/03/31/1131254.jpg"></li>
            <li><img src="http://dl.bizhi.sogou.com/images/2014/11/28/981054.jpg"></li>
          </ul>
        </div>
      </div>
      <div id="cq-setting-others" class="cq-setting-content">
        <div class="title">其他设置 <small><a href="https://github.com/evecalm/clean-qzone/issues/new" target="_blank">有其他功能建议?</a></small></div>
        <!--
        <div class="cq-input-wrapper">
          <input type="checkbox" id="cq-disable-bgm-ckbx">
          <label for="cq-disable-bgm-ckbx">禁止自动播放背景音乐</label>
          <label class="cq-label js-enable-ibgm">
            <input type="checkbox" id="cq-enable-ibgm-ckbx"> 只允许我的空间自动播放背景音乐
          </label>
        </div>
        -->
        <div class="cq-input-wrapper">
          <label><input type="checkbox" id="cq-disable-qvip-ckbx"> 移除所有黄钻相关的logo/菜单/推广</label>
        </div>
      </div>
    </div>
  </div>
  '''
  getSettingPanel.wp = document.createElement 'div'
  getSettingPanel.wp.classList.add 'cq-overlay'
  # getSettingPanel.wp.classList.add 'cq-hide'
  getSettingPanel.wp.innerHTML = html
  document.body.appendChild getSettingPanel.wp
  getSettingPanel.wp

attachSettingPanelEvents = ->
  # 左侧菜单列表
  document.getElementById('cq-settings-menus').addEventListener 'click', onMenuItemClick
  # 添加关键字按钮
  document.getElementById('cq-kwd-add-btn').addEventListener 'click', onAddKwdBtn
  # 删除关键字
  document.getElementById('cq-kwds-list').addEventListener 'click', onRemoveKwd
  # 启用主题
  document.getElementById('cq-theme-ckbx').addEventListener 'change', onSwitchTheme
  # 添加主题
  document.getElementById('cq-theme-add-btn').addEventListener 'click', onAddThemeClick
  # 选择主题
  document.getElementById('cq-themes-list').addEventListener 'click', onThemeClick
  # 关闭对话框
  document.querySelector('.cq-settings-close').addEventListener 'click', ->
    do toggleSettingDlg
  # 全局按escape键
  # 如对话框可见, 则隐藏, 并阻止事件冒泡, 避免暂停背景音乐
  document.addEventListener 'keydown', (e)->
    return if e.keyCode isnt 27 or e.target.tagName.toLowerCase() is 'input'
    if document.documentElement.classList.contains 'cq-show-setting-dlg'
      do toggleSettingDlg
      do e.stopPropagation
    return
  , true
  # 关键字输入框的键盘事件
  document.getElementById('cq-kwd-input').addEventListener 'keydown', (e)->
    # escape键
    if e.keyCode is 27
      do e.stopPropagation
      return
    # 回车键
    if e.keyCode is 13
      document.getElementById('cq-kwd-add-btn').click()
    return
  # 主题url输入框的键盘事件
  document.getElementById('cq-themeurl-input').addEventListener 'keydown', (e)->
    # escape键
    if e.keyCode is 27
      do e.stopPropagation
      return
    # 回车键
    if e.keyCode is 13
      document.getElementById('cq-theme-add-btn').click()
    return

  # 切换黄钻的开关
  document.getElementById('cq-disable-qvip-ckbx').addEventListener 'change', ->
    toggleAllVipLogo this.checked
    return

# 切换菜单激活状态
onMenuItemClick = (e)->
  elem = e.target
  return unless elem.tagName.toLowerCase() is 'li'
  return if elem.classList.contains 'active'

  now = this.querySelector '.active'
  if now then now.classList.remove 'active'
  elem.classList.add 'active'

  targetId = elem.getAttribute 'data-target'
  return unless targetId

  now = document.getElementById('cq-setting-wrapper').querySelector('.cq-setting-content.active')
  if now then now.classList.remove 'active'

  elem = document.getElementById targetId
  if elem then elem.classList.add 'active'
  return

# 添加关键字
onAddKwdBtn = (e)->
  ipt = document.getElementById 'cq-kwd-input'
  v = ipt.value.trim()
  return unless v
  if lstore.addKwd v
    prependKwd v
    ipt.value = ''
  else
    console.log '关键字已存在'
  return

# 追加关键字
prependKwd  = (v)->
  li = document.createElement 'li'
  li.innerHTML = "#{encodeHtml(v)}<span class='close'></span>"
  list = document.getElementById 'cq-kwds-list'
  list.insertBefore li, list.firstElementChild
  return

# 删除关键字
onRemoveKwd = (e)->
  target = e.target
  return unless target.tagName.toLowerCase() is 'span' and target.classList.contains 'close'
  li = target.parentElement

  kwd = li.textContent.trim()
  lstore.removeKwd kwd
  removeElement li
  return


# 刷新关键字列表
refreshKwdsList = ->
  kwds = do lstore.getKwds
  html = kwds.reduce (prev, kwd)->
    prev + "<li>#{encodeHtml(kwd)}<span class='close'></span></li>"
  , ''
  document.getElementById('cq-kwds-list').innerHTML = html
  return

# 启用/禁用样式
onSwitchTheme = ->
  enabled = this.checked
  toggleTheme enabled
  if enabled then do resetTheme
  
  return

# 切换主题显示效果
toggleTheme = (enabled)->
  enabled = !!enabled
  document.documentElement.classList[if enabled then 'add' else 'remove'] 'cq-yosemite'
  lstore.set 'yosemite-theme', enabled
  return

# 重置背景
resetTheme = ->
  themeList = document.getElementById 'cq-themes-list'
  selectedTheme = themeList.querySelector('.cq-selected') or themeList.firstElementChild
  return unless selectedTheme
  selectedTheme.classList.add 'cq-selected'
  updateBgImg selectedTheme.querySelector('img').src
  return

# 加载图片
loadImg = (url, done, fail)->
  img = new Image
  img.onload = done if done
  img.onerror = fail if fail
  img.src = url
  return
# 添加主题
onAddThemeClick = ->
  return unless url = document.getElementById('cq-themeurl-input').value
  loadImg url, -> prependTheme url
  return

# 添加主题
prependTheme = (url)->
  unless lstore.addBgimg url
    # 图片已存在
    return
  document.getElementById('cq-themeurl-input').value = ''

  li = document.createElement 'li'
  li.innerHTML = '<span class="cq-close"></span><img src="' + url + '">'
  themeList = document.getElementById 'cq-themes-list'
  themeList.insertBefore li, themeList.firstElementChild
  # 选中新增的主题
  do li.querySelector('img').click
  return

# 初始化主题列表
initThemeList = ->
  bgimgs = do lstore.getBgimgs
  frg = document.createDocumentFragment()
  bgimgs.forEach (bgimg)->
    li = document.createElement 'li'
    li.innerHTML = '<span class="cq-close"></span><img src="' + bgimg + '">'
    frg.appendChild li
    return
  
  themeList = document.getElementById 'cq-themes-list'
  themeList.insertBefore frg, themeList.firstElementChild
  
  if (bgImgUrl = lstore.get 'bgimg') and (img = themeList.querySelector '[src="' + bgImgUrl + '"]')
    img.parentElement.classList.add 'cq-selected'
    
  return

# 选择主题
onThemeClick = (e)->
  target = e.target
  li = target.parentElement
  # 切换主题
  if target.tagName.toLowerCase() is 'img'
    return if li.classList.contains 'cq-selected'
    this.querySelector('.cq-selected')?.classList.remove 'cq-selected'
    li.classList.add 'cq-selected'
    updateBgImg target.src
  else if target.classList.contains 'cq-close'
    lstore.removeBgimg li.querySelector('img').src
    removeElement li
  return

# 更新背景图片
updateBgImg = (url)->
  unless updateBgImg.wp and url
    updateBgImg.wp = document.createElement 'div'
    updateBgImg.wp.classList.add 'cq-bg'
    document.body.insertBefore updateBgImg.wp, document.body.firstElementChild
  updateBgImg.wp.style.backgroundImage = "url(#{url})"
  lstore.set 'bgimg', url
  return

# 向QQ空间的菜单中追加clean qzone的菜单
addSettingMenu = ->
  return unless menus = document.querySelector '#tb_setting_panel .drop-down-setting'
  menu = document.createElement 'a'
  menu.href = 'javascript:;'
  menu.textContent = 'Clean Qzone'
  menu.addEventListener 'click', ->
    toggleSettingDlg true
    return
  menus.insertBefore menu, menus.firstElementChild
  return

# 显示或隐藏黄钻相关的logo
toggleAllVipLogo = (isRemove)->
  isRemove = !!isRemove
  document.documentElement.classList[if isRemove then 'add' else 'remove'] 'cq-remove-qzvip'
  lstore.set 'disable-all-vip-logo', isRemove
  return

initSettingPanel = ->
  do getSettingPanel
  do addSettingMenu
  do attachSettingPanelEvents
  do initThemeList

  # 显示/隐藏黄钻相关标志
  if lstore.get 'disable-all-vip-logo'
    toggleAllVipLogo true
    document.getElementById('cq-disable-qvip-ckbx').checked = true
    
  # 启用yosemite主题
  enableTheme = lstore.get 'yosemite-theme'
  if enableTheme and (bgImgUrl = lstore.get 'bgimg')
    document.getElementById('cq-theme-ckbx').checked = true
    toggleTheme enableTheme
    updateBgImg bgImgUrl
  return
  