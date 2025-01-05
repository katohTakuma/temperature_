#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2024 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32
import random

class Temperature(Node):
    def __init__(self):
        super().__init__("temperature")
        self.pub = self.create_publisher(Float32, "temperature", 10)
        self.create_timer(1.0, self.publish_temperature)  # 1秒ごとに実行

    def publish_temperature(self):
        msg = Float32()
        msg.data = round(random.uniform(15.0, 25.0),1)  # ランダムな温度データ（15.0～25.0度>）
        self.pub.publish(msg)
        self.get_logger().info(f"Published temperature: {msg.data:.1f}°C")


def main():
    rclpy.init()
    node = Temperature()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == "__main__":
    main()
