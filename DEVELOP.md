## 開発環境

### セットアップ

ESP-IDF v4系では動作しないためv3系の最新版をセットアップする

1. ESP-IDF v3.3.1用のToolchainをインストールする
   - [zipファイル](https://dl.espressif.com/dl/esp32_win32_msys2_environment_and_toolchain-20181001.zip)を c:\\msys32 へ展開
   - MSYS2 MINGW32 ターミナル(C:\\msys32\\mingw32.exe)を起動
   - 必要なディレクトリを作成
     - $ mkdir -p ~/esp
2. ESP-IDF v3.3.1をインストールする
   - MSYS2 MINGW32 ターミナルを起動
   - ESP-IDFをダウンロード
     - $ cd ~/esp
     - $ git clone -b v3.3.1 --recursive https://github.com/espressif/esp-idf.git
   - 環境変数 IDF_PATH を設定
     - $ cd /etc/profile.d/
     - $ echo export IDF_PATH=\\"C:/msys32/home/USER_NAME/esp/esp-idf\\" > export_idf_path.sh
     - ※USER_NAMEは適宜変更
   - ターミナルを再起動して環境変数が設定されていることを確認
     - $ printenv IDF_PATH
   - 必要なPythonパッケージをインストール
     - $ python -m pip install --user -r $IDF_PATH/requirements.txt

## ビルドと実行

- 初期設定
  - $ make menuconfig
    - Camera model
      - Camera board : M5-Camera B
    - Serial flasher config
      - Default serial port : /dev/ttyUSB0 ※適宜変更
      - Default baud rate : 921600 baud
      - 'idf.py monitor' baud rate : 115200 baud
    - Save して Exit
- ビルド
  - $ cd wifi-ap ※適宜変更
  - $ make
- ボードへ書き込み
  - $ make flash
- モニター
  - $ make monitor