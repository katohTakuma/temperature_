#!/bin/bash
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

set -e

if [ -f "/opt/ros/humble/setup.bash" ]; then
    source /opt/ros/humble/setup.bash
elif [ -f "/opt/ros/foxy/setup.bash" ]; then
    source /opt/ros/foxy/setup.bash
else
    echo "ROS setup.bashが見つかりません"
    exit 1
fi

colcon build

source install/setup.bash

ros2 run temperature_node temperature &
sleep 2 


echo " /temperatureトピックをテストしています..."
ros2 topic pub --once /temperature std_msgs/Float32 "{data: 26.0}"
sleep 1 

echo "/temperature_warningトピックをテストしています..."
ros2 topic echo /temperature_warning --once

# スクリプトの終了
echo "テスト成功"

