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
