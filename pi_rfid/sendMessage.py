#!/usr/bin/env python3

import paho.mqtt.client as mqtt

# This is the Publisher

receiver_address = "172.16.116.139"
client = mqtt.Client()


def publishMessage(message,topic):
	client.connect(receiver_address)
	client.publish(topic,message)
	client.disconnect()
	



