# 温度管理シミュレーションノード
![test](https://github.com/katohTakuma/temperature_/actions/workflows/test.yml/badge.svg)

## 概要
temperatureは、ランダムな温度データをROS2トピック /temperature にパブリッシュするシミュレーションノードです。
- 温度範囲: 15.0°C ～ 30.0°C
- 25.0°C以上のときに「高温警告」をログに出力

## 動作環境
- ubuntu-22.04
- ROS2: テスト済み（foxy）

## 使用方法
### 1. 環境をセットアップ
```bash
$ git clone https://github.com/katohTakuma/temperature_.git

$ cd temperature_

$ colcon build

$ source install/setup.bash
```


### 2. ノードを起動
#### 温度データをパブリッシュ
```bash
$ ros2 run mypkg temperature
```
#### トピックデータを確認: 別ターミナルで以下を実行
```bash
$ ros2 topic echo /temperature
```

## 動作例
- ros2 run mypkg temperatureの実行時
 #### 正常な温度の場合:
  [INFO] [時間] [temperature]: 正常な温度です

 #### 高温警告の場合:
  [WARN] [時間] [temperature]: 高温になっています


- ros2 topic echo /temperatureの実行時
#### 生成された温度をトピックに出力
  data: 17.5
 
  ---
  
  data: 26.7

  
### トピック(/temperature)
 温度センサーの値を模倣したランダムな温度データを配信するROS 2トピックです。

  
## 注意事項
- **シミュレーション専用:** 実際の温度センサーは使用していません。
- **リスナーノード:** 他のノードがトピックデータを利用する場合、リスナーノードは別で作成してください。

## ライセンス
- © 2025 katoh takuma
- 本ソフトウェアは BSD-3-Clauseライセンス で提供されています。
- 本パッケージのコードは、Ryuichi Ueda氏の許可を得て、下記のスライドとコンテナ環境(© 2025 Ryuichi Ueda)（CC-BY-SA 4.0)を一部参考にし、自身の著作として作成したものです。
- [Robot Operating System(ROS2)](https://ryuichiueda.github.io/slides_marp/robosys2024/lesson8.html#22)
- [ROS 2の通信と型](https://ryuichiueda.github.io/slides_marp/robosys2024/lesson9.html#19)
- [ROSシステムのテスト](https://ryuichiueda.github.io/slides_marp/robosys2024/lesson10.html#8)
- [ryuichiueda/ubuntu22.04-ros2](https://hub.docker.com/r/ryuichiueda/ubuntu22.04-ros2)

# 参考資料
[2>&1はどういう意味？](https://qiita.com/TomohiroSaito/items/1393ce5a01b75adcbf30)

[【必須】grepコマンドを使いこなす](https://qiita.com/yagiryu/items/6128ad998560510be5de)

[rclpy throws an exception when it is interrupted-rclpy.executors.ExternalShutdownException](https://github.com/ros2/rclpy/issues/1166)

[ランダムに出力！Pythonでrandomを使う方法【初心者向け】](https://magazine.techacademy.jp/magazine/15821)

[githubの"Process completed with exit code 1."というエラーはなんなのか](https://qiita.com/KerorinNF/questions/939cb56ed00ea5da665f)
