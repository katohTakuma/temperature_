#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2025 katoh takuma
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String
from std_msgs.msg import Float32
import random


class Temperature(Node):
    def __init__(self):
        super().__init__("temperature")
        self.pub = self.create_publisher(Float32, "temperature", 10)
        self.warning_pub = self.create_publisher(String, "temperature_warning", 10)
        self.create_timer(1.0, self.publish_temperature)

    def publish_temperature(self):
        msg = Float32()
        msg.data = round(random.uniform(15.0, 30.0), 1)
        self.pub.publish(msg)

        # 高温時の警告メッセージを日本語に変更
        if msg.data > 25.0:
            warning_msg = String()
            warning_msg.data = f"警告: 温度が安全基準を超えています ({msg.data}°C)"
            self.warning_pub.publish(warning_msg)


def main(args=None):
    rclpy.init(args=None)
    node = Temperature()
    try:
        rclpy.spin(node)
    except rclpy.executors.ExternalShutdownException:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()


if __name__ == "__main__":
    main()

