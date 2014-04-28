'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var chalk = require('chalk');


var MyTemplateGenerator = yeoman.generators.Base.extend({
  init: function () {
    this.pkg = require('../package.json');

    this.on('end', function () {
      if (!this.options['skip-install']) {
        this.installDependencies();
      }
    });
  },

  askFor: function () {
    var done = this.async();

    // have Yeoman greet the user
    this.log(this.yeoman);

    // replace it with a short and sweet description of your generator
    this.log(chalk.magenta('You\'re using the fantastic staticWebsite generator.'));

    var prompts = [

      // base
      {
        name: 'projectname',
        message: 'プロジェクト名を入力してください',
        default: "someproject"
      },
      {
        name: 'yourname',
        message: 'あなたの名前を入力してください',
        default: "someuser"
      },
      {
        name: 'repository',
        message: 'リポジトリURLを入力してください',
        default: ""
      },
      {
        name: 'src',
        message: 'ソースファイルパスを入力してください',
        default: "./src"
      },
      {
        name: 'dist',
        message: 'デプロイ先のパスを入力してください',
        default: "./htdocs"
      },

      // html
      {
        type: 'list',
        name: 'html',
        message: 'HTMLジェネレータを選択してください',
        choices: [{
          name   : '使わない',
          value  : 'none'
        }, {
          name   : 'jade',
          value  : 'jade'
        }, {
          name   : 'ect',
          value  : 'ect'
        }]
      },
      {
        type: 'confirm',
        name: 'htmllint',
        message: 'HTMLファイルをバリデートしますか?',
        default: false
      },

      // css
      {
        type: 'list',
        name: 'css',
        message: 'CSSジェネレータを選択してください',
        choices: [{
          name: '使わない',
          value: 'none'
        }, {
          name: 'stylus',
          value: 'stylus'
        }, {
          name: 'sass(compass)',
          value: 'sass'
        }]
      },
      {
        type: 'confirm',
        name: 'csslint',
        message: 'CSSファイルをバリデートしますか?',
        default: false
      },

      // js
      {
        type: 'confirm',
        name: 'jshint',
        message: 'jshintを使いますか?',
        default: false
      },
      {
        type: 'confirm',
        name: 'concat',
        message: 'JSファイルを結合しますか?',
        default: false
      },

      // ユーティリティ
      {
        type: 'confirm',
        name: 'connect',
        message: 'ローカルサーバを使いますか?',
        default: false
      },
      {
        type: 'confirm',
        name: 'imagemin',
        message: '画像を圧縮しますか?',
        default: false
      },
      {
        type: 'confirm',
        name: 'sprite',
        message: 'sprite画像を使いますか?',
        default: false
      }

    ];

    this.prompt(prompts, function (props) {
      this.projectname = props.projectname;
      this.yourname    = props.yourname;
      this.repository  = props.repository;
      this.src         = props.src;
      this.dist        = props.dist;
      this.repository  = props.repository;
      this.html        = props.html;
      this.htmllint    = props.htmllint;
      this.css         = props.css;
      this.csslint     = props.csslint;
      this.jshint      = props.jshint;
      this.concat      = props.concat;
      this.connect     = props.connect;
      this.imagemin    = props.imagemin;
      this.sprite      = props.sprite;
      done();
    }.bind(this));
  },

  app: function () {

    this.mkdir('libs');
    this.mkdir('htdocs');
    this.mkdir('htdocs/common/img');
    this.mkdir('htdocs/common/css');
    this.mkdir('htdocs/common/js');
    this.mkdir('htdocs/common/js/libs');

    this.template('_package.json', 'package.json');
    this.template('_bower.json', 'bower.json');
    this.template('Gruntfile.coffee');

    // html
    switch(this.html) {
      case 'none':
        this.copy('htdocs/index.html', 'htdocs/index.html');
        break;
      case 'jade':
        this.copy('src/jade/index.jade', 'src/jade/index.jade');
        break;
      case 'ect':
        this.copy('src/ect/index.ect', 'src/ect/index.ect');
        break;
    }
    if (this.htmllint) {
      this.copy('htmlhintrc', '.htmlhintrc');
    }

    // css
    switch(this.css) {
      case 'stylus':
        this.copy('src/styl/style.styl', 'src/styl/style.styl');
        break;
      case 'sass':
        this.copy('src/scss/style.scss', 'src/scss/style.scss');
        break;
    }
    if (this.csslint) {
      this.copy('csslintrc', '.csslintrc');
    }

    // javascript
    if (this.jshint) {
      this.copy('src/js/script.js', 'src/js/script.js');
      this.copy('jshintrc', '.jshintrc');
    }

    // ユーティリティ
    if (this.sprite) {
      this.mkdir('sprites');
    }

  },

  projectfiles: function () {
    this.template('README.md', 'README.md');
    this.copy('gitignore', '.gitignore');
  }

});

module.exports = MyTemplateGenerator;