# 显示版本更新信息
showExtUpdateAlert = ->



# 显示/隐藏设置对话
toggleSettingsDlg = (isShow)->
  wp = do getSettingPanel
  wp.classList[if isShow then 'remove' else 'add'] 'cq-hide'
  if isShow then do refreshKwdsList
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
        <div class="cq-input-wrapper">
          <label><input type="checkbox" id="cq-theme-checkbox"> 启用 Yosemite 主题, 高大上!</label>
        </div>
        <div class="cq-theme-choose-wrapper" id="cq-theme-choose-wrapper">
          <div class="cq-input-wrapper">
            选择下列背景图, 或者自定义图片URL
            <input type="text" class="cq-input"> <button class="cq-btn" id="cq-theme-add-btn">设置</button>
          </div>
          <ul class="cq-themes" id="cq-themes-list">
            <li class="cq-selected"><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>
            <li><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>
            <li><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>
            <li><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  '''
  getSettingPanel.wp = document.createElement 'div'
  getSettingPanel.wp.classList.add 'cq-overlay'
  getSettingPanel.wp.classList.add 'cq-hide'
  getSettingPanel.wp.innerHTML = html
  document.body.appendChild getSettingPanel.wp
  getSettingPanel.wp

attachSettingPanelEvents = ->
  document.getElementById('cq-settings-menus').addEventListener 'click', onMenuItemClick

  document.getElementById('cq-kwd-add-btn').addEventListener 'click', onAddKwdBtn
  document.getElementById('cq-kwds-list').addEventListener 'click', onRemoveKwd

  document.getElementById('cq-theme-checkbox').addEventListener 'change', onSwitchTheme
  document.getElementById('cq-theme-add-btn').addEventListener 'click', onAddThemeClick
  document.getElementById('cq-themes-list').addEventListener 'click', onThemeClick
  document.querySelector('.cq-settings-close')?.addEventListener 'click', ->
    do toggleSettingsDlg

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
  list.insertBefore li, list.firstChild
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

# 启用/禁用样式
onSwitchTheme = ->
  enabled = this.checked
  document.getElementById('cq-theme-choose-wrapper').classList[if enabled then 'remove' else 'add'] 'cq-disabled'
  document.documentElement.classList[if enabled then 'add' else 'remove'] 'cq-yosemite'
  return

# 刷新关键字列表
refreshKwdsList = ->
  kwds = do lstore.getKwds
  html = kwds.reduce (prev, kwd)->
    prev + "<li>#{encodeHtml(kwd)}<span class='close'></span></li>"
  , ''
  document.getElementById('cq-kwds-list').innerHTML = html
  return


# 添加主题
onAddThemeClick = ->

# 选择主题
onThemeClick = (e)->
  target = e.target
  return unless target.tagName.toLowerCase() is 'img'
  li = target.parentElement
  return if li.classList.contains 'cq-selected'
  this.querySelector('.cq-selected')?.classList.remove 'cq-selected'
  li.classList.add 'cq-selected'
  updateBgImg target.src
  return

# 更新背景图片
updateBgImg = (url)->
  unless updateBgImg.wp and url
    updateBgImg.wp = document.createElement 'div'
    updateBgImg.wp.classList.add 'cq-bg'
    document.body.insertBefore updateBgImg.wp, document.body.firstChild
  updateBgImg.wp.style.backgroundImage = "url(#{url})"
  return

# 向QQ空间的菜单中追加clean qzone的菜单
addSettingMenu = ->
  return unless menus = document.querySelector '#tb_setting_panel .drop-down-setting'
  menu = document.createElement 'a'
  menu.href = 'javascript:;'
  menu.textContent = 'Clean Qzone'
  menu.addEventListener 'click', ->
    toggleSettingsDlg true
    return
  menus.insertBefore menu, menus.firstChild
  return


initSettingPanel = ->
  do getSettingPanel
  do addSettingMenu
  do attachSettingPanelEvents
  return
  