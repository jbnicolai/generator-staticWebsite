# generator-staticWebsite

> [Yeoman](http://yeoman.io) generator

## これはなに？

Yeoman用のスタティックサイトジェネレータです。  
Gruntfileを毎回作るのはつらいのでコレを使ってラクをしよう！

### HTML

- ノーマル / Assemble / Jade の3つから選択できます。
- バリデーションチェックの要否も選択できます(grunt-htmlhint)。
- バリデーションのレベルは .htmlhintrc で調整できます。詳しくはこちら。[Rules · yaniswang/HTMLHint Wiki](https://github.com/yaniswang/HTMLHint/wiki/Rules)

### CSS

- ノーマル / Stylus(nib含む) / Sass(Compass含む) の3つから選択できます。
- バリデーションチェックの要否も選択できます(grunt-contrib-csslint)。
- バリデーションのレベルは .csslintrc で調整できます。詳しくはこちら。[Rules · CSSLint/csslint Wiki](https://github.com/CSSLint/csslint/wiki/Rules)

### JavaScript

- バリデーションチェックの要否が選択できます(grunt-contrib-jshint)。
- バリデーションのレベルは .jshintrc で調整できます。詳しくはこちら。[JSHint Options Reference](http://www.jshint.com/docs/options/)
- JSファイル結合の要否が選択できます。
- JSファイルミニファイの要否が選択できます。
- 必要なライブラリは Bower でダウンロードします。
- ダウンロードされたライブラリは Grunt を実行すると自動で vendor.js にまとめられます。
- 依存関係を操作する場合や追加でライブラリをダウンロードする場合は Gruntfile.coffee に追記します。

### その他

- ローカルサーバーの要否を選択できます。
- 画像最適化の要否を選択できます。
- CSS Sprite生成の要否を選択できます。

## 使い方

### Yeomanのインストール

```
$ npm install -g yo
```

###  generator-staticWebsiteのインストール

```
$ npm install -g generator-staticwebsite
```

### ファイル生成

```
$ yo staticWebsite
```

-----

### Getting To Know Yeoman

Yeoman has a heart of gold. He's a person with feelings and opinions, but he's very easy to work with. If you think he's too opinionated, he can be easily convinced.

If you'd like to get to know Yeoman better and meet some of his friends, [Grunt](http://gruntjs.com) and [Bower](http://bower.io), check out the complete [Getting Started Guide](https://github.com/yeoman/yeoman/wiki/Getting-Started).


## License

MIT
