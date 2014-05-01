# Generated on <%= (new Date).toISOString().split('T')[0] %> using
# <%= pkg.name %> <%= pkg.version %>

pkg = require './package.json'

###
grunt設定
###
module.exports = (grunt) ->

  for taskName of pkg.devDependencies
    if taskName.substring(0, 6) == 'grunt-' then grunt.loadNpmTasks taskName

  <% if (html === 'assemble') { %>
  grunt.task.loadNpmTasks 'assemble'
  <% } %>

  config =

    pkg: grunt.file.readJSON('package.json')

    <% if (html === 'jade') { %>
    ###
    grunt-contrib-jade
    @ htmlファイルをビルド
    @ _付きファイルはパーシャルファイルなのでhtmlへの出力はしない
    ###
    jade:
      dist:
        options:
          pretty : true
        expand: true
        cwd   : '<%%= pkg.path.src %>/jade'
        src   : ['**/!(_)*.jade']
        dest  : '<%%= pkg.path.dist %>'
        ext   : '.html'
    <% } %>

    <% if (html === 'assemble') { %>
    ###
    assemble
    @ htmlファイルをビルド
    ###
    assemble:
      files:
        expand: true
        cwd   : '<%%= pkg.path.src %>/assemble/pages'
        src   : ['**/*.hbs']
        dest  : '<%%= pkg.path.dist %>'
    <% } %>

    <% if (htmllint) { %>
    ###
    grunt-htmlhint
    ###
    htmlhint:
      options:
        htmlhintrc: '.htmlhintrc'
        html1:
          src:[ '<%%= pkg.path.dist %>/**/*.html' ]
    <% } %>

    <% if (css === 'stylus') { %>
    ###
    grunt-contrib-stylus
    ###
    stylus:
      dist:
        options:
          compress: false
          import: ["nib"]
        expand: true
        cwd   : '<%%= pkg.path.src %>/styl'
        src   : ['**/!(_)*.styl']
        dest  : '<%%= pkg.path.src %>/assets/css'
        ext   : '.css'
    <% } %>

    <% if (css === 'sass') { %>
    ###
    grunt-contrib-compass
    @ cssファイルをビルド
    @ _付きファイルはパーシャルファイルなのでcssへの出力はしない
    ###
    compass:
      dist:
        options:
          sassDir  : '<%%= pkg.path.src %>/scss'
          cssDir   : '<%%= pkg.path.src %>/assets/css'
          imagesDir: '<%%= pkg.path.src %>/assets/img'
          relativeAssets: true
          noLineComments: true
          assetCacheBuster: false
    <% } %>

    <% if (csslint) { %>
    ###
    grunt-contrib-csslint
    ###
    csslint:
      options:
        csslintrc: '.csslintrc'
      lax:
        options:
          import: false
        src: [ '<%%= pkg.path.src %>/assets/css/**/*.css' ]
    <% } %>

    <% if (jshint) { %>
    ###
    grunt-contrib-jshint
    ###
    jshint:
      options:
        jshintrc: '.jshintrc'
      source:
        expand: true
        cwd: '<%%= pkg.path.src %>/js'
        src: [ '**/*.js' ]
        filter: 'isFile'
    <% } %>

    <% if (concat) { %>
    ###
    grunt-contrib-concat
    @ jsファイルを結合
    ###
    concat:
      dist:
        files:
          '<%%= pkg.path.src %>/assets/js/scripts.js': [
            
          ]
    <% } %>

    <% if (imagemin) { %>
    ###
    grunt-contrib-imagemin
    ###
    imagemin:
      dynamic:
        files:
          expand: true
          cwd: '<%%= pkg.path.src %>/assets/img',
          src: ['**/*.{png,jpg,gif}']
          dest: '<%%= pkg.path.src %>/assets/img'
    <% } %>

    <% if (sprite) { %>
    ###
    grunt-spritesmith
    @ スプライト画像生成
    ###
    sprite:
      dist:
        src      : 'sprites/*.png'
        destImg  : '<%%= pkg.path.src %>/assets/img/sprite.png'
        destCSS  : '<%%= pkg.path.src %>/assets/css/sprite.css'
        imgPath  : "../img/sprite.png"
        padding  : 10
        algorithm: "binary-tree"
        cssOpts:
          cssClass: (sprite) ->
            sprite.name = '.sp-' + sprite.name
    <% } %>

    <% if (connect) { %>
    ###
    grunt-contrib-connect
    @ ローカルサーバー
    ###
    connect:
      server:
        options:
          port    : 3000
          base    : '<%%= pkg.path.dist %>'
          hostname: '0.0.0.0'
          spawn   : false
    <% } %>

    ###
    grunt-contrib-copy
    @ アセッツのコピー
    ###
    copy:
      assets:
        expand : true
        cwd    : '<%%= pkg.path.src %>/assets'
        src    : [
          '**/*'
          '!sprites'
        ]
        dest   : '<%%= pkg.path.dist %>/assets'

    ###
    grunt-bower-concat
    @ Bowerライブラリ圧縮
    ###
    bower_concat:
      all:
        dest: '<%%= pkg.path.src %>/assets/js/libs/vendor.js'
        exclude: [
          'jquery',
          'modernizr',
          'underscore',
          'lodash'
        ]
        dependencies: 
          'jQuery.EaseScroller': ['EaseStepper', 'jquery.easing']
        bowerOptions:
          relative: false

    ###
    grunt-license-saver
    @ ライブラリライセンス管理
    ###
    'save_license':
      'libs' :
        'src'  : ['<%%= pkg.path.src %>/assets/js/libs/vendor.js']
        'dest' : '<%%= pkg.path.src %>/assets/js/libs/license.text'

    ###
    grunt-contrib-uglify
    @ js圧縮
    ###
    uglify:
      options:
        banner: '/* Libraries license: "./license.txt" */'
      vendor:
        files:
          '<%%= pkg.path.src %>/assets/js/libs/vendor.min.js': [
            '<%%= pkg.path.src %>/assets/js/libs/vendor.js'
          ]

    ###
    grunt-notify
    @ ビルド通知
    ###
    notify:
      build:
        options:
          title  : 'ビルド完了'
          message: 'タスクが正常終了しました。'
      watch:
        options:
          title  : '監視開始'
          message: 'ローカルサーバーを起動しました'

    ###
    grunt-contrib-watch
    @ 更新監視
    ###
    watch:
      options:
        livereload: true
        spawn     : false
      html:
        files: [
          <% if (html === 'jade') { %>'<%%= pkg.path.src %>/jade/**/*.jade'<% } %>
          <% if (html === 'assemble') { %>'<%%= pkg.path.src %>/assemble/**/*.hbs'<% } %>
          <% if (html === 'none') { %>'<%%= pkg.path.dist %>/**/*.html'<% } %>
        ]
        tasks: [
          <% if (html === 'jade') { %>'jade'<% } %>
          <% if (html === 'assemble') { %>'assemble'<% } %>
          <% if (htmllint) { %>'htmlhint'<% } %>
          'notify:build'
        ]
      css:
        files: [
          <% if (css === 'stylus') { %>'<%%= pkg.path.src %>/styl/**/*.styl'<% } %>
          <% if (css === 'sass') { %>'<%%= pkg.path.src %>/scss/**/*.scss'<% } %>
          <% if (css === 'none') { %>'<%%= pkg.path.src %>/assets/css/**/*.css'<% } %>
        ]
        tasks: [
          <% if (css === 'stylus') { %>'stylus'<% } %>
          <% if (css === 'compass') { %>'compass'<% } %>
          <% if (csslint) { %>'csslint'<% } %>
          'notify:build'
        ]
      js:
        files: [
          '<%%= pkg.path.src %>/js/**/*.js'
        ]
        tasks: [
          <% if (jshint) { %>'jshint'<% } %>
          <% if (concat) { %>'concat'<% } %>
          'notify:build'
        ]

  grunt.initConfig( config )

  grunt.registerTask 'default', []

  # grunt start
  grunt.registerTask 'start', [
    'bower_concat'
    'save_license'
    <% if (html === 'jade') { %>'jade'<% } %>
    <% if (html === 'assemble') { %>'assemble'<% } %>
    <% if (htmllint) { %>'htmlhint'<% } %>
    <% if (sprite) { %>'sprite'<% } %>
    <% if (css === 'stylus') { %>'stylus'<% } %>
    <% if (css === 'sass') { %>'compass'<% } %>
    <% if (csslint) { %>'csslint'<% } %>
    <% if (jshint) { %>'jshint'<% } %>
    <% if (concat) { %>'concat'<% } %>
    'uglify'
    'copy:assets'
    'notify:watch'
    <% if (connect) { %>'connect'<% } %>
    'watch'
  ]

  # grunt build
  grunt.registerTask 'build', [
    'bower_concat'
    'save_license'
    <% if (html === 'jade') { %>'jade'<% } %>
    <% if (html === 'assemble') { %>'assemble'<% } %>
    <% if (htmllint) { %>'htmlhint'<% } %>
    <% if (sprite) { %>'sprite'<% } %>
    <% if (css === 'stylus') { %>'stylus'<% } %>
    <% if (css === 'sass') { %>'compass'<% } %>
    <% if (csslint) { %>'csslint'<% } %>
    <% if (jshint) { %>'jshint'<% } %>
    <% if (concat) { %>'concat'<% } %>
    'uglify'
    'copy:assets'
    'notify:build'
  ]