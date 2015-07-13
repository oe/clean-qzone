module.exports = (grunt)->
  # APP 的发布目录地址
  DIST_APP_PATH = 'dist'
  pkg = grunt.file.readJSON 'package.json'
  banner = '''
// ==UserScript==
// @name           Clean Qzone
// @namespace      com.saiya.clean-qzone
// @description    <%= pkg.description %>
// @match          http://*.qzone.qq.com/*
// @include        http://*.qzone.qq.com/*
// @updateURL      <%= pkg.extFilePath %>/clean-qzone.meta.js
// @downloadURL    <%= pkg.extFilePath %>/clean-qzone.user.js
// @version        <%= pkg.version %>
// ==/UserScript==
// source code: <%= pkg.repository %>\n
'''
  update_check_url = "#{pkg.extFilePath}/clean-qzone.user.js"

  
  # 增加版本号
  increaseVersion = (version)->
    max = 20
    vs = version.split('.').map (i)-> +i
    len = vs.length
    while len--
      break if (++vs[ len ]) < max
      vs[ len ] = 0
    vs.join '.'

  # pkg.version = increaseVersion pkg.version

  # 用户生成检查新版本的的脚本
  updateInfo =
    version: pkg.version
    updateMsg: '功能优化, bug修复'

  banner = grunt.template.process banner, data: pkg : pkg
  grunt.initConfig
    pkg: pkg
    # 清理文件夹
    clean:
      options:
        # 强制清理
        force: true
      js: DIST_APP_PATH

    # 合并文件
    concat:
      'clean-qzone.user.coffee':
        src:[
          'src/utils.coffee'
          'src/lstore.coffee'
          'src/ui-optimize.coffee'
          'src/clean-ads.coffee'
          'src/clean-qzone.coffee'
        ]
        dest: DIST_APP_PATH + '/clean-qzone.user.coffee'

    # 编译less
    less:
      main:
        options:
          compress: true
          plugins: [
            new (require('less-plugin-autoprefix'))()
          ]
        src: 'src/css/clean-qzone.less'
        dest: DIST_APP_PATH + '/clean-qzone.css'


    # 替换版本号
    replace:
      options:
        patterns: [
          {
            # 自定义样式, 实际替换的是 @@$$STYLE_TEXT$$ 下同
            match: '$$STYLE_TEXT$$'
            replacement: ->
              fs = require 'fs'
              styleText = fs.readFileSync DIST_APP_PATH + '/clean-qzone.css', 'utf8'
              JSON.stringify styleText
          },
          {
            # ext版本
            match: '$$VERSION$$'
            replacement: JSON.stringify pkg.version
          },
          {
            # 检查更新的URL地址
            match: '$$UPDATE_CHECK_URL$$'
            replacement: JSON.stringify update_check_url
          }
        ]
      main:
        src: DIST_APP_PATH + '/clean-qzone.user.coffee'
        dest: DIST_APP_PATH + '/clean-qzone.user.coffee'


    # 编译coffee
    coffee:
      'clean-qzone.user.coffee':
        options:
          bare: true
          sourceMap: false
        src: DIST_APP_PATH + '/clean-qzone.user.coffee'
        dest: DIST_APP_PATH + '/clean-qzone.debug.user.js'

    # umd包装
    umd:
      main:
        template: 'umd-template.hbs'
        src: DIST_APP_PATH + '/clean-qzone.debug.user.js'
        dest: DIST_APP_PATH + '/clean-qzone.user.js'

    # 压缩JS代码
    uglify:
      options:
        banner: banner
        # 移除console打印的日志
        # compress:
          # drop_console: true
        # 设置不压缩的关键字
        # mangle:
        #   except: ['require']
      min:
        options:
          sourceMap: false
        src: DIST_APP_PATH + '/clean-qzone.debug.user.js'
        dest: DIST_APP_PATH + '/clean-qzone.user.js'



  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-replace'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-umd'

  grunt.registerTask 'get-meta-file', ->
    # 更新 meta file, 方便油猴等脚本管理扩展自动更新脚本
    m = banner.replace /\/UserScript==[\s\S]*$/, '/UserScript==\n'
    grunt.file.write DIST_APP_PATH + '/clean-qzone.meta.js', m, 'utf8'
    
    # 更新用于检查脚本是否有新版本的 js
    u = 'checkCqUpdate(' + JSON.stringify(updateInfo) + ')'
    grunt.file.write DIST_APP_PATH + '/clean-qzone.check-update.js', u, 'utf8'
    # 更新package.json 用于保存新版本
    grunt.file.write 'package.json', JSON.stringify(pkg, null, 2), 'utf8'
    return


  grunt.registerTask 'app', [
    'clean'
    'concat'
    'less'
    'replace'
    'coffee'
    'umd'
    'uglify'
    'get-meta-file'
  ]

  grunt.registerTask 'default', ['app']
