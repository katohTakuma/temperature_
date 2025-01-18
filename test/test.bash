#!/bin/bash
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

# スクリプトをエラーで停止
set -e

# 環境設定
source /opt/ros/foxy/setup.bash
source /root/ros2_ws/install/setup.bash

# テスト用ログディレクトリ
LOG_DIR=/root/test_logs
mkdir -p $LOG_DIR

# ノードをバックグラウンドで起動
echo "Starting the temperature node..."
ros2 run temperature_node temperature &> $LOG_DIR/temperature_node.log &
NODE_PID=$!

# ノードが起動するのを少し待つ
sleep 2

# トピックの確認
echo "Checking topics..."
ros2 topic list | grep -q "/temperature"
ros2 topic list | grep -q "/temperature_warning"

# トピックから値を取得
echo "Echoing topics..."
ros2 topic echo /temperature --once &> $LOG_DIR/temperature.log
ros2 topic echo /temperature_warning --once &> $LOG_DIR/temperature_warning.log

# 値の確認
echo "Verifying topic values..."
TEMP_VALUE=$(grep "data:" $LOG_DIR/temperature.log | awk '{print $2}')
WARN_VALUE=$(grep "data:" $LOG_DIR/temperature_warning.log | awk '{print $2}')

# 高温時の警告が正しく出ているかをチェック
if (( $(echo "$TEMP_VALUE > 25.0" | bc -l) )); then
  if [ "$TEMP_VALUE" != "$WARN_VALUE" ]; then
    echo "Error: /temperature_warning did not receive the expected value."
    kill $NODE_PID
    exit 1
  fi
fi

# ノードを停止
kill $NODE_PID

echo "All tests passed successfully."

