#!/bin/bash
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

set -e  # エラーが出たらスクリプトを終了

# 引数で指定されたディレクトリを設定（デフォルトはホームディレクトリ）
dir=~
[ "$1" != "" ] && dir="$1"

# ROS 2 ワークスペースへ移動
cd $dir/ros2_ws

# ビルドの実行
colcon build

# ROS 2 の環境をセットアップ
source $dir/.bashrc

# temperature ノードをバックグラウンドで起動
echo "温度ノードを起動しています..."
ros2 run temperature_node temperature > /tmp/temperature.log &
NODE_PID=$!

# ノードが準備できるまで少し待機
sleep 3

# 温度をテストパブリッシュ
echo "温度データを /temperature トピックに送信しています..."
ros2 topic pub --once /temperature std_msgs/Float32 "{data: 26.0}" > /dev/null

# 温度警告トピックを確認
echo "温度警告メッセージを /temperature_warning トピックから購読しています..."
if ros2 topic echo /temperature_warning --once | grep -q "警告"; then
    echo "警告メッセージを正常に受信しました。"
else
    echo "警告メッセージが受信できませんでした。"
    exit 1
fi

# ノードの終了を確認
echo "テストが完了しました。温度ノードの終了を待っています..."
wait $NODE_PID

echo "スクリプトが正常に終了しました。"

