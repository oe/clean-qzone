module.exports = (grunt)->
  # APP 的发布目录地址
  DIST_APP_PATH = 'dist'
  pkg = grunt.file.readJSON 'package.json'
  banner = '''
// ==UserScript==
// @name           Clean Qzone
// @namespace      com.saiya.clean-qzone
// @description    <%= pkg.description %>
// @match          http://user.qzone.qq.com/*
// @updateURL      http://app.evecalm.com/search/googlelink.meta.js
// @downloadURL    http://app.evecalm.com/search/googlelink.user.js
// @version        <%= pkg.version %>
// ==/UserScript==
// source code: https://github.com/evecalm/clean-qzone\n
'''

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
          'src/style.coffee'
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
            # 实际替换的是 @@$$KK_VERSION$$
            match: '$$STYLE_TEXT$$',
            replacement: ->
              fs = require 'fs'
              styleText = fs.readFileSync DIST_APP_PATH + '/clean-qzone.css', 'utf8'
              JSON.stringify styleText
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
  # grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'

  grunt.registerTask 'app', ['clean', 'concat', 'less', 'replace:main', 'coffee', 'uglify']

  grunt.registerTask 'default', ['app']
