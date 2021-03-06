# 低遅延Wi-Fi FPVの試作

## 概要

### 方針

- 解像度を落とす
- 画質を落とす
- 到達保証しない(UDPで運ぶ)
- Wi-Fiを最適化する

### システム構成

- 送信側
  - [M5Camera Model B](https://docs.m5stack.com/#/ja/unit/m5camera)
- 受信側/開発環境
  - Windows 10 64bit 搭載PC
  - Webブラウザ
  - ESP-IDF v3.3.1

### 開発環境の構築

[こちら](DEVELOP.md)のドキュメントを参照のこと。

## 実験1. リファレンス実装の実力値

### 条件

- Wi-Fiモード : AP
- 映像設定 : SVGA(800x600), JPEG(Q15), 30fps
- 転送方式 : MJPEG over HTTP
- 表示手段 : PC上のブラウザ

### 結果

<a href="docs/exp01.mp4?raw=true"><img src="docs/exp01.jpg" width="200"></a>
- フレームレート : 25~30fps
- 遅延 : 約130ms

## 実験2. 極端に解像度を落とす

### 条件

- Wi-Fiモード: AP
- 映像設定: QQVGA(160x120), JPEG(Q15), 60fps
- 転送方式: MJPEG over HTTP
- 表示手段: PC上のブラウザ

### 結果

<a href="docs/exp02.mp4?raw=true"><img src="docs/exp02.jpg" width="200"></a>
- フレームレート : 50~55fps
- 遅延 : 約100ms

## 実験3. 適切な解像度に戻す

### 条件

- Wi-Fiモード: AP
- 映像設定: CIF(400x296), JPEG(Q15), 60fps
- 転送方式: MJPEG over HTTP
- 表示手段: PC上のブラウザ

### 結果

<a href="docs/exp03.mp4?raw=true"><img src="docs/exp03.jpg" width="200"></a>
- フレームレート : 45~55fps
- 遅延 : 約100ms

## 実験4. UDPで送信する

### 条件

- Wi-Fiモード: Station
- 映像設定: QQVGA(160x120), JPEG(Q15), 60fps
- 転送方式: UDP(独自フォーマット)
- 表示手段: PC上の専用アプリ(要開発)

### メモ

- リファレンス実装
    - https://github.com/m5stack/m5stack-cam-psram/tree/master/wifi
- 解像度(抜粋)
    - FRAMESIZE_QQVGA // 160x120
    - FRAMESIZE_QCIF // 176x144
    - FRAMESIZE_QVGA // 320x240
    - FRAMESIZE_CIF // 400x296
    - FRAMESIZE_VGA // 640x480
    - FRAMESIZE_SVGA // 800x600
- JPEG品質
    - 0~63で指定
    - 数が小さいほど高画質/大容量

## 実行方法

### MJPEG over HTTP版 (http/)

1. M5Cameraの電源を入れる
2. PCからM5CameraのWi-Fi APに接続する
3. ブラウザで以下のURLを開く
    - http://192.168.4.1/ -> フレーム間引きなし(最大60fps)
    - http://192.168.4.1/?skip=1 -> 1フレーム間引く(最大30fps)
    - http://192.168.4.1/?skip=2 -> 2フレーム間引く(最大20fps)
    - http://192.168.4.1/?skip=3 -> 3フレーム間引く(最大15fps)

### UDP版

未実装

## 残課題

- 重量
    - ケース込みで12.9g
    - ケース除くと6.5g
- 電源
    - もともとLiPoバッテリーで駆動できる設計
    - 消費電力が気になる
- レンズ
    - 標準添付品は画角が狭い
    - 交換できるようにネジが切ってある
- 電波干渉
    - プロポとの干渉？

## 参考情報

### 既製品のスペック

| 製品名                                                       | 伝送遅延       | 接続方式 | 解像度, FPS      | 税抜価格 |
| ------------------------------------------------------------ | -------------- | -------- | ---------------- | -------- |
| [G-FORCE GB246](http://www.gforce-hobby.jp/products/GB390-b.html) | 約200ms (実測) | Wi-FI    | 不明             | 4,800円  |
| [KYOSHO 2.4GHz FPVシステム](https://rc.kyosho.com/ja/82724.html) | 160ms以上      | FHSS     | 420 x 272, 30fps | 11,000円 |

### 技術情報

- [Get Started - ESP-IDF Programming Guide v3.3.1 documentation](https://docs.espressif.com/projects/esp-idf/en/v3.3.1/get-started/windows-setup.html)
- [M5Cameraのサンプルプログラムをビルドする(2020.02版)](https://qiita.com/lutecia16v/items/e76129ea3c4160f270f2)

以上

