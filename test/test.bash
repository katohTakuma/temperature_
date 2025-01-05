#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"
cd $dir/ros2_ws
colcon build
source $dir/.bashrc

# `temperature` ノードを起動してログを記録
timeout 10 ros2 run mypkg temperature > /tmp/temperature.log

# ログから温度データをフィルタリングして表示
cat /tmp/temperature.log | grep 'Published temperature:'

