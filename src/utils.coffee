###*
 * create a fn that will delay to exec util wait milliseconds has passed
 *     since last time invoked
 * @param  {Function} fn      fn to exec
 * @param  {Object}   context fn's exec context
 * @param  {Number}   wait    time to wait, millisecond
 * @return {Function}           a new fn
###
debounce = (fn, context, wait)->
  tid = null
  wait = 200 if isNaN(wait) or wait < 0
  # if content is a number, assign it to wait
  if not isNaN context
    wait = context if context > 0
    context = undefined
  ->
    clearTimeout tid
    tid = setTimeout ->
      fn?.call context
      return
    , wait
    return

###*
 * create a new function that will exec every wait milliseconds even when
 *     it frequently invoked
 * @param  {Function} fn      fn to exec
 * @param  {Object}   context fn's exec context
 * @param  {Number}   wait    time to wait, milisecond
 * @return {Function}           a new function
###
throttle = (fn, context, wait)->

  last = false
  tid = null
  wait = 200 if isNaN(wait) or wait < 0
  # if content is a number, assign it to wait
  if not isNaN context
    wait = +context if context > 0
    context = undefined
  ->
    now = + new Date()
    last = now if last is false
    remain = wait - (now - last)
    clearTimeout tid
    if remain <= 0
      fn?.call context
      wait = false
    else
      tid = setTimeout ->
        fn?.call context
        return
      , remain
    return

# get parent element that has class pClass
getParent = (elem, pClass)->
  while elem
    return elem if elem.classList.contains pClass
    elem = elem.parentElement
  return

# remove element from DOM tree
removeElement = (elem)->
  if elem and elem.parentElement
    elem.parentElement.removeChild elem
    true
  else
    false

# 转义HTML实体
encodeHtml = (str)->
  String(str)
  .replace /&/g, '&amp;'
  .replace /</g, '&lt;'
  .replace />/g, '&gt;'
  .replace /"/g, '&quot;'

