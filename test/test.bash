#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"
cd $dir/ros2_ws
colcon build
source $dir/.bashrc

timeout 10 ros2 run mypkg temperature > /tmp/temperature.log

cat /tmp/temperature.log | grep 'Published temperature:'
