#!/bin/bash

# デフォルトのディレクトリを設定
dir=~
[ "$1" != "" ] && dir="$1"  # 引数があればそれをディレクトリに設定

cd $dir/ros2_ws || exit 1  # ディレクトリに移動できなければエラー終了

# ビルド
colcon build || exit 1
source install/setup.bash || exit 1

# ログファイルのパス
log_file="/tmp/temperature_test.log"

# テストノードを起動して10秒間データを待つ
timeout 10 ros2 topic echo /temperature > $log_file &  # トピックの出力をキャプチャ
test_pid=$!  # プロセスIDを取得

# テストノード（temperature.py）を起動
ros2 run mypkg temperature || exit 1

# 10秒間待機してテストノードを終了
wait $test_pid
kill $test_pid 2>/dev/null

# ログファイルを確認し、温度データが存在するかチェック
if grep -E "data: [0-9]+(\.[0-9])?" $log_file; then
  echo "Temperature test passed!"
  exit 0  # 正常終了
else
  echo "Temperature test failed!"
  exit 1  # 異常終了
fi

