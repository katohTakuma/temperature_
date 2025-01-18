#!/bin/bash
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

# スクリプトをエラーで停止
set -e

# 環境設定
if [ -f "/opt/ros/humble/setup.bash" ]; then
    source /opt/ros/humble/setup.bash
elif [ -f "/opt/ros/foxy/setup.bash" ]; then
    source /opt/ros/foxy/setup.bash
else
    echo "ROS setup.bash not found!"
    exit 1
fi

# ワークスペースのビルド
colcon build

# ノードをバックグラウンドで起動
source install/setup.bash
ros2 run temperature_node temperature &  # ノード起動
TEMP_NODE_PID=$!  # 起動したノードのPIDを保存

# トピックのテスト
sleep 2  # ノードが起動し、トピックを発行し始めるのを待つ
ros2 topic pub /temperature std_msgs/Float32 "{data: 26.0}" &
ros2 topic echo /temperature_warning --once

# ノードを終了
kill $TEMP_NODE_PID

