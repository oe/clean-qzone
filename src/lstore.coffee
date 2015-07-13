# 插件数据存储
lstore =
  _storeKey: 'isa-cq-settings'
  kwdsKey: 'kwds'
  

  set: (key, val)->
    @_data[ key ] = val
    do @save

  get: (key)->
    @_data[ key ]

  save: ->
    localStorage.setItem @_storeKey, JSON.stringify @_data

  getKwds: ->
    kwds = @get @kwdsKey
    kwds ?= []
    kwds

  addKwd: (kwd)->
    kwds = @getKwds @kwdsKey
    return false if kwd in kwds
    kwds.unshift kwd
    @set @kwdsKey, kwds
    true

  removeKwd: (kwd)->
    kwds = @getKwds @kwdsKey
    idx = kwds.indexOf kwd
    return unless ~idx
    kwds.splice idx, 1
    @set @kwdsKey, kwds

lstore._data = do ->
  d = localStorage.getItem lstore._storeKey
  JSON.parse d or '{}'