#!/bin/bash
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

set -e

if [ -f "/opt/ros/humble/setup.bash" ]; then
    source /opt/ros/humble/setup.bash
elif [ -f "/opt/ros/foxy/setup.bash" ]; then
    source /opt/ros/foxy/setup.bash
else
    echo "ROS setup.bash not found!"
    exit 1
fi

colcon build

source install/setup.bash
ros2 run temperature_node temperature &
TEMP_NODE_PID=$!

sleep 2
ros2 topic pub /temperature std_msgs/Float32 "{data: 26.0}" &
ros2 topic echo /temperature_warning --once

kill $TEMP_NODE_PID

