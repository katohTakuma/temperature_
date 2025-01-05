#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"
cd $dir/ros2_ws
colcon build
source $dir/.bashrc

timeout 10 ros2 run mypkg temperature > /tmp/mypkg.log 2>&1
grep '今の温度は:' /tmp/mypkg.log
