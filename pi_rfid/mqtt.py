import paho.mqtt.client as mqtt
import time

def onMessage(client, userdata, message):
	topic = str(message.topic)
	message = str(message.payload.decode("utf-8"))
	print("Received Message:",topic,message)
	


hostname = "172.16.116.139" 
client = mqtt.Client("rpi")


client.connect(hostname)
client.subscribe("notif")
client.on_message = onMessage
client.loop_start()


while(1):
	s = input()
	client.publish("notif", s)
	time.sleep(4)
	




