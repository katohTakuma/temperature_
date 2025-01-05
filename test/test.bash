#!/bin/bash
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause


dir=~
[ "$1" != "" ] && dir="$1"
cd $dir/ros2_ws
colcon build
source $dir/.bashrc

timeout 10 ros2 run mypkg temperature > /tmp/mypkg.log 2>&1

echo "=== 温度ログのチェック ==="
grep '正常な温度です' /tmp/mypkg.log

echo "=== 高温警告メッセージのチェック ==="
grep '高温になっています' /tmp/mypkg.log

