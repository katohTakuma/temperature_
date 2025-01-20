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

timeout 20s ros2 run temperature_node temperature &

ros2 topic echo /temperature_warning --once

ros2 topic pub /temperature std_msgs/Float32 "{data: 26.0}" --once

echo "すべてのテストが完了しました。"

