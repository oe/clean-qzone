# 插件数据存储
lstore =
  _storeKey: 'isa-cq-settings'
  kwdsKey: 'kwds'
  bgimgsKey: 'bgimg-list'

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
    kwds = do @getKwds
    return false if kwd in kwds
    kwds.unshift kwd
    @set @kwdsKey, kwds
    true

  removeKwd: (kwd)->
    kwds = do @getKwds
    idx = kwds.indexOf kwd
    return false unless ~idx
    kwds.splice idx, 1
    @set @kwdsKey, kwds
    true

  getBgimgs: ->
    bgimgs = @get @bgimgsKey
    bgimgs ?= []
    bgimgs

  removeBgimg: (url)->
    bgimgs = do @getBgimgs
    idx = bgimgs.indexOf url
    return false unless ~idx
    bgimgs.splice idx, 1
    @set @bgimgsKey, bgimgs
    return true

  addBgimg: (url)->
    bgimgs = do @getBgimgs
    return false if url in bgimgs
    bgimgs.unshift url
    @set @bgimgsKey, bgimgs
    true

lstore._data = do ->
  d = localStorage.getItem lstore._storeKey
  JSON.parse d or '{}'