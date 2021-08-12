# makePjFolders

## 概要
MATLAB/Simulinkのプロジェクトフォルダを作ります。
具体的には
* data, scripts, models などのフォルダを作成し、プロジェクトに追加
* 必要なフォルダのパスを通す
* cache, コード生成用のフォルダの設定
をします。

## 使い方

プロジェクトを作成したいフォルダで実行します。 プロジェクト名を指定すると、prjファイル名とプロジェクト名がその
名前に設定されます。
```MATLAB
makePjFolders PjTest
```

## 必要なもの
* MATLAB

## 注意
エラー処理をほとんどしていません。ご自分の責任でお使い下さい。

## ライセンス
Copyright (c) 2021 GordiusTears
Released under the [MIT license](https://github.com/GordiusTears/makePjFolders/blob/8e03556baa14eeb150a6f09561b8ec7d2fb810e4/MIT-LICENSE.txt)

