#!/bin/bash
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause


if [ -f "/opt/ros/humble/setup.bash" ]; then
    source /opt/ros/humble/setup.bash
elif [ -f "/opt/ros/foxy/setup.bash" ]; then
    source /opt/ros/foxy/setup.bash
else
    echo "ROS の setup.bash が見つかりません"
    exit 1
fi

colcon build

source install/setup.bash

test_count=3

for i in $(seq 1 $test_count); do
    echo "テスト $i 番目を実行しています..."

    timeout 10s ros2 run temperature_node temperature &

    ros2 topic pub /temperature std_msgs/Float32 "{data: 26.0}" &

    ros2 topic echo /temperature_warning --once

    echo "テスト $i 番目が完了しました。"
done

echo "すべてのテストが完了しました。"

