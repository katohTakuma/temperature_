#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32
import random

class Temperature(Node):
    def __init__(self):
        super().__init__("temperature")
        self.pub = self.create_publisher(Float32, "temperature", 10)
        self.warning_pub = self.create_publisher(Float32, "temperature_warning", 10)  # 高温警告用のトピック
        self.create_timer(1.0, self.publish_temperature)  # 1秒ごとに実行

    def publish_temperature(self):
        msg = Float32()
        msg.data = round(random.uniform(15.0, 30.0), 1)
        self.pub.publish(msg)

        if msg.data > 25.0:
            self.warning_pub.publish(msg)  # 高温時は警告トピックに出力
        else:
            self.get_logger().info(f"正常な温度です: {msg.data}°C")


def main(args=None):
    rclpy.init(args=None)
    node = Temperature()
    try:
        rclpy.spin(node)
    except rclpy.executors.ExternalShutdownException:
        node.get_logger().info("Node was externally shut down.")
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == "__main__":
    main()

