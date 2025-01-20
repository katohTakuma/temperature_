#!/bin/bash
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

set -e

if [ -f "/opt/ros/humble/setup.bash" ]; then
    source /opt/ros/humble/setup.bash
elif [ -f "/opt/ros/foxy/setup.bash" ]; then
    source /opt/ros/foxy/setup.bash
else
    echo "ROS の setup.bash が見つかりません！"
    exit 1
fi

colcon build

source install/setup.bash

# テストを繰り返す回数
test_count=3  # ここでテストの回数を変更

# 試行回数分繰り返す
for i in $(seq 1 $test_count); do
    echo "テスト $i 番目を実行しています..."

    # ノードをバックグラウンドで実行
    ros2 run temperature_node temperature &
    TEMP_NODE_PID=$!

    sleep 2

    # トピックにデータを送信
    ros2 topic pub /temperature std_msgs/Float32 "{data: 26.0}" &
    
    # トピックを購読
    ros2 topic echo /temperature_warning --once

    # プロセスの終了を待機
    wait $TEMP_NODE_PID

    echo "テスト $i 番目が完了しました。"
done

echo "すべてのテストが完了しました。"
D

