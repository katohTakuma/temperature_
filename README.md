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
  このパッケージの動作確認用トピック `/temperature` については、ユーザーが通常利用することを想定していないため、ここでは説明を省略します。

## 使い方
1つ目のターミナルで以下を実行します。
```bash
$ ros2 run temperature_node temperature
```
2つ目のターミナルで以下を実行します。
```bash
ros2 topic echo /temperature_warning
```
これにより正常な温度はログに出力し、異常な温度(このパッケージでは25度以上)の場合はトピックに出力します。

### 実行例

下記は実行例です：
```bash
$ ros2 run temperature_node temperature
[INFO] [1737223940.463750766] [temperature]: 正常な温度です: 18.5°C
[INFO] [1737223941.457519160] [temperature]: 正常な温度です: 22.7°C
```

### 出力結果
```bash
$ ros2 topic echo /temperature_warning
data: 25.799999237060547
---
data: 26.899999618530273
```


## テスト環境
- **ローカル環境**:
  - Ubuntu 20.04.6 LTS
  - ROS2: foxy
 
- **GitHub Actions環境**:
  - Ubuntu 22.04

## 権利

- © 2025 katoh takuma
- 本ソフトウェアパッケージは、3条項BSDライセンスのもとで再配布や利用が認められています
- 本パッケージの一部のコードは、上田隆一氏の許可を得て、下記のスライド(© 2025 Ryuichi Ueda)（CC-BY-SA 4.0)を一部参考にし、自身の著作として作成されたものです
  - [Robot Operating System (ROS 2)](https://ryuichiueda.github.io/slides_marp/robosys2024/lesson8.html#20)
  
## 参考資料

 - 使用させていただいたコンテナ: [ryuichiueda/ubuntu22.04-ros2:latest](ryuichiueda/ubuntu22.04-ros2:latest)
 - [if文を使った条件分岐](https://www.javadrive.jp/python/if/index1.html)
 - [ROSシステムのテスト](https://ryuichiueda.github.io/slides_marp/robosys2024/lesson10.html#1)
 - [Pythonでランダムな小数・整数を生成するrandom, randrange, randintなど](https://note.nkmk.me/python-random-randrange-randint/)
 - [ノードの再起動を跨いだPIDの衝突について](https://qiita.com/sile/items/c1a357efdaa9cae4cd9c)
 - [Pythonのsleep関数とは？概要や使い方、応用例を解説](https://and-engineer.com/articles/ZqOo2xEAACcA8C4A)
 - [子プロセスを含めたkill](https://qiita.com/hirayama_yuuichi/items/4f097c66cb0ffc2c6db2)
