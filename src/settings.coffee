# 显示版本更新信息
showExtUpdateAlert = ->



# 显示设置对话
showSettingsDlg = ->

# 追加
appendSettingsHtml = ->

attachEvents = ->
  document.getElementById('cq-settings-menus').addEventListener 'click', onMenuItemClick

  document.getElementById('cq-kwd-add-btn').addEventListener 'click', onAddKwdBtn
  document.getElementById('cq-kwds-list').addEventListener 'click', onRemoveKwd

  document.getElementById('cq-theme-checkbox').addEventListener 'change', onSwitchTheme
  document.getElementById('cq-theme-add-btn').addEventListener 'click', onThemeCkbxChange
  document.getElementById('cq-themes-list').addEventListener 'click', onThemeClick

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
  else
    console.log '关键字已存在'
  return

# 追加关键字
prependKwd  = (v)->
  li = document.createElement 'li'
  li.innerHTML = "#{v}<span class='close'></span>"
  list = document.getElementById 'cq-kwds-list'
  list.insertBefore li, list.firstChild
  return

# 删除关键字
onRemoveKwd = (e)->
  target = e.target
  return unless target.tagName.toLowerCase() is 'span' and target.classList.contains 'close'
  li = target.parentElement

  kwd = li.innerText.trim()
  lstore.removeKwd kwd
  removeElement li
  return
# 启用/禁用样式
onSwitchTheme = ->
  enabled = this.checked
  document.getElementById('cq-theme-choose-wrapper').classList[if enabled then 'remove' else 'add'] 'cq-disabled'
  document.documentElement[if enabled then 'add' else 'remove'] 'cq-yosemite'
  return
# 选择主题
onThemeClick = (e)->


closeSettingDlg = ->

  