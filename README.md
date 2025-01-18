# Temperatureノード
![test](https://github.com/katohTakuma/temperature_node/actions/workflows/test.yml/badge.svg)

## 概要
temperature_nodeはROS 2のパッケージです。温度の監視を行い、温度データをパブリッシュし、超えてはいけない値の場合には別のトピックで高温警告を発行します。あくまでもシミュレーション用なのでtemperature.pyはランダムに値を出力するようにしています。

## 使い方

ワークスペースをビルドします：

cd ~/ros2_ws
colcon build
source install/setup.bash

ノードを起動します：

ros2 run temperature_node temperature

トピックを追跡します：

温度データ: /temperature

高温警告: /temperature_warning

ros2 topic echo /temperature
ros2 topic echo /temperature_warning

## 実行例と結果

下記は、温度を模擬した際の実行例です：

温度データの確認：

ros2 topic echo /temperature

data: 23.4

data: 24.7

高温警告の確認：

ros2 topic echo /temperature_warning
---
data: 26.0

## 参考資料

ROS 2 Documentation

使用したコンテナイメージ: ryuichiueda/ubuntu22.04-ros2:latest

テスト環境

ROS 2: Foxy

## 権利

SPDX-License-Identifier: BSD-3-Clause

