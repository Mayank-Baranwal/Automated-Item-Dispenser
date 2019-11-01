import paho.mqtt.client as mqtt
import time
import mailProf
from mailProf import sendMail

hostname = "172.16.116.139" 

items = {
	0: "BreadBoard",
	1: "IC 781",
	2: "LED Strip",
}


lowInventoryMessage = "This is an auto generated mail! %s Content in the inventory is low! Kindly look into the same."
dispensingFailureMsg = "This is an auto generated mail! %s failed to dispense from the dispenser! Kindly look into the same."
pickupFailureMsg = "This is an auto generated mail! %s dispensed but wasn't picked up! Kindly look into the same."

def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))
    client.subscribe("topic/Dispenser")

def onMessage(client, userdata, message):
	topic = str(message.topic)
	message = str(message.payload.decode('utf-8'))
	whichItem = int(message[-1])
	print("Received Message:", message)
	if(message[0] == "L"):
		sendMail("Item Dispenser Warning",lowInventoryMessage % (items[whichItem]) ) # Implement this #
	elif(message[0] == "D"):
		sendMail("Item Dispenser Warning",dispensingFailureMsg % (items[whichItem]))
	elif(message[0] == "P"):
		sendMail("Item Dispenser Warning",pickupFailureMsg % (items[whichItem]))
		
	return
	
def myMessage(client,userdata,message):
	message = str(message.payload.decode('utf-8'))
	print(message)
		
client = mqtt.Client("server")
client.on_connect = on_connect
client.on_message = onMessage
client.connect(hostname)
client.loop_forever()



