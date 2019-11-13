#!/usr/bin/env python3

import paho.mqtt.client as mqtt

# This is the Publisher

receiver_address = "localhost"
client = mqtt.Client()

def publishMessage(message,topic):
	client.connect(receiver_address)
	client.publish(topic,message)
	client.disconnect()
	

if __name__ == "__main__":
	publishMessage("Llahh 0","topic/Dispenser")


