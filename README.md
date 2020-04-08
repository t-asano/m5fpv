# 低遅延Wi-Fi FPVの試作

## 開発環境

- Windows 10 64bit
- [ESP-IDF](https://github.com/espressif/esp-idf)
- [M5Camera Model B](https://docs.m5stack.com/#/ja/unit/m5camera)

## 低遅延化のアプローチ

- 解像度を落とす
- 画質を落とす
- 到達保証しない(UDPで運ぶ)
- Wi-Fiを最適化する

## 開発環境の整備

- ESP-IDF Tools Installerを実行すればOK
  - https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/windows-setup.html
  - PythonとGitも必要(無ければついでにインストールされる)

## 実験

### 1. 工場出荷状態の実力値を見る

おそらく2.と同じプログラムが書き込まれているものと想像。

### 2. リファレンス実装の実力値を見る

- Wi-Fiモード: AP
- 映像設定: SVGA(800x600), JPEG(Q15), 30fps
- 転送方式: HTTP, Motion JPEG
- 表示手段: PC上のブラウザ

### 3. 極端に解像度を落としてみる

- Wi-Fiモード: AP
- 映像設定: QQVGA(160x120), JPEG(Q15), 60fps
- 転送方式: HTTP, Motion JPEG
- 表示手段: PC上のブラウザ

### 4. PC側をアクセスポイントとしてみる

- Wi-Fiモード: Station
- 映像設定: QQVGA(160x120), JPEG(Q15), 60fps
- 転送方式: HTTP, Motion JPEG
- 表示手段: PC上のブラウザ

### 5. UDPで送信してみる

- Wi-Fiモード: Station
- 映像設定: QQVGA(160x120), JPEG(Q15), 60fps
- 転送方式: UDP(独自フォーマット), JPEG
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

## その他の課題

- 重量
    - ケース込みで12.9g
    - 公式情報では5g(どの部分？)
- 電源
    - 通常はUSBから給電
- レンズ
    - 標準添付品は画角が狭い
    - 効果できるようにネジが切ってある
- マウント
- 電波干渉
    - プロポとの干渉？

## 既製品のスペック

| 製品名                                                       | 伝送遅延       | 接続方式 | 解像度, FPS      | 税抜価格 |
| ------------------------------------------------------------ | -------------- | -------- | ---------------- | -------- |
| [G-FORCE GB246](http://www.gforce-hobby.jp/products/GB390-b.html) | 約200ms (実測) | Wi-FI    | 不明             | 4,800円  |
| [KYOSHO 2.4GHz FPVシステム](https://rc.kyosho.com/ja/82724.html) | 160ms以上      | FHSS     | 420 x 272, 30fps | 11,000円 |

以上

