# temperature_node
![test](https://github.com/katohTakuma/temperature_node/actions/workflows/test.yml/badge.svg)

## 概要
- temperature_nodeは温度データをパブリッシュし、超えてはいけない値の場合にはトピックに出すパッケージです。
- あくまでもシミュレーション用なので、このパッケージでは温度データはランダムに出力するようにしています。

### トピック
- `/temperature_warning`
  - **役割**: 温度が25.0°Cを超えた場合に、高温警告メッセージをパブリッシュします。
  - **データ型**: `std_msgs/msg/Float32`

- **注**:
  このパッケージの動作確認用トピック `/temperature` は、ユーザーが通常利用することを想定していないため説明を省略します。

## 使い方
1つ目のターミナルで以下を実行します。
```bash
$ ros2 run temperature_node temperature
```
2つ目のターミナルで以下を実行します。
```bash
ros2 topic echo /temperature_warning
```
これにより異常な温度(このパッケージでは25度以上)の場合はトピックに出力します。

### 実行例

下記は実行例です：
```bash
$ ros2 run temperature_node temperature
(何も表示されない)
```
### 出力結果
```bash
$ ros2 topic echo /temperature_warning
data: '警告: 温度が安全基準を超えています (27.3°C)'
---
data: '警告: 温度が安全基準を超えています (29.0°C)'
```


## テスト環境
- **ローカル環境**:
  - Ubuntu 20.04.6 LTS
  - ROS2: foxy
 
- **GitHub Actions環境**:
  - Ubuntu 22.04


## 参考資料

 - [if文を使った条件分岐](https://www.javadrive.jp/python/if/index1.html)
   
 - [ROSシステムのテスト](https://ryuichiueda.github.io/slides_marp/robosys2024/lesson10.html#1)
   
 - [Pythonでランダムな小数・整数を生成するrandom, randrange, randintなど](https://note.nkmk.me/python-random-randrange-randint/)
   
 - [ノードの再起動を跨いだPIDの衝突について](https://qiita.com/sile/items/c1a357efdaa9cae4cd9c)
   
 - [Pythonのsleep関数とは？概要や使い方、応用例を解説](https://and-engineer.com/articles/ZqOo2xEAACcA8C4A)
   
#### 使用させていただいたコンテナ
   - [ryuichiueda/ubuntu22.04-ros2:latest](ryuichiueda/ubuntu22.04-ros2:latest)

## ライセンス
- 本ソフトウェアパッケージは、3条項BSDライセンスのもとで再配布や使用が認められています。
- © 2025 Katoh Takuma

  
