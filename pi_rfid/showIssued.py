#!/usr/bin/env python

import RPi.GPIO as GPIO
from mfrc522 import SimpleMFRC522
import json
import time
import ultrasonic
import color
import keypad 
from keypad import input
import servo
import sendMessage
import stepperMotor

fileName = "database.txt"
countFile="totalCount.txt"
topic = "topic/Dispenser"
PASSWORD=5

item = {
	"WHITE" : "BreadBoard",
	"GREEN": "IC 781",
	"BLUE": "LED Strip",
}

itemNum = {
	"WHITE" : 0,
	"GREEN": 1,
	"BLUE": 2,
}

def getAllCounts():
	data = {}
	with open(countFile) as f:
		try:
			data = json.load(f)
		except Exception as e:
			data = {}
	count=data["total"]
	return count
	

def changeCount(itemNumber,flag):
	temp = getAllCounts()
	data = {}
	
	if flag==0:
		temp[itemNumber]+=1
	else:
		temp[itemNumber]-=1
	data["total"] = temp
	
	with open(countFile,'w') as f:
		json.dump(data,f)
	
	return

def addItem():
	print("Scan item in front of colour sensor")
	time.sleep(2) # Wait for 2 seconds #
	addedItem = color.getColour()
	pass # INCREMENT COUNT HERE #
	val=itemNum[addedItem]
	changeCount(val,0)
	print("Added Item", item[addedItem])
	



def readRFID():
	try:
		reader = SimpleMFRC522()
		id, text = reader.read()
	finally:
		GPIO.cleanup()
	
	return str(id)

def findAllRecords():
	data = {}
	with open(fileName) as f:
		try:
			data = json.load(f)
		except Exception as e:
			data = {}
	
	return data 

def writeRecord(rfID ,toBeIssued, currIssued,groupNo):
	data = findAllRecords()
	data[rfID] = [toBeIssued, currIssued,groupNo]
	
	with open(fileName,'w') as f:
		json.dump(data,f)
		
	return
	
def readRecord(rfID):
	data = findAllRecords()
	return data[rfID]

def issueItems(rfID):
	tobeIssued, currIssued, groupNo = readRecord(rfID) 
	issueNext = True
	for i,itemCount in enumerate(tobeIssued):
		if(itemCount <= 0):
			continue
		
		for _ in range(0,itemCount):
			allCounts = getAllCounts()
			if(allCounts[i] <= 0):
				sendMessage.publishMessage("Low Inventory " + str(i), topic)
				break
			pass # Call for a rotation #
			print('Pick item after it is dispensed.')
			# IF PROXIMITY Doesn't reply in 10s CALL FAILURE #
			status = ultrasonic.foo()
			#status = 2
			if status == 0:
				print('Could not dispense item!')
				sendMessage.publishMessage("Dispensing Failed " + str(i),topic)
				issueNext = False
				break
			elif status == 1:
				print('Item dipensed but not picked up!')
				sendMessage.publishMessage("Pickup Failed " + str(i),topic)
				tobeIssued[i] -= 1
				currIssued[i] += 1
				issueNext = False
				changeCount(i,1)
				break
			else:
				print("Issued item " , str(i) )
				tobeIssued[i] -= 1
				currIssued[i] += 1
				changeCount(i,1)
				time.sleep(2)
	
		if not issueNext: break
	#print("Pending Issues: " , tobeIssued)
	#print("Current Issued: " , currIssued)
	writeRecord(rfID,tobeIssued,currIssued,groupNo)
	return
	
def setIssueValues(count):
	tobeIssued = []
	for i in range(0,count):
		print("Enter Count for item" , i) 
		val= int(input())
		tobeIssued.append(val)
	
	data = findAllRecords()
	for rfID in data:
		currIssued = data[rfID][1]
		groupNo = data[rfID][2]
		writeRecord(rfID, tobeIssued, currIssued, groupNo)
	
	return
	
def returnItems(count):
	val=0
	while(1):
		print("Enter group number to be updated. Enter 0 to update for all groups, -1 to exit")
		val=input()
		if(val=="#"):
			break
		temp=[]
		for i in range(0,count):
			print("Enter return count for item" , i) 
			val2= int(input())
			temp.append(val2)
		if(val=="0"):
			data = findAllRecords()
			for rfID in data:
				tobeIssued=data[rfID][0]
				currIssued=data[rfID][1]
				groupNo=data[rfID][2]
				for j in range(0,count):
					currIssued[j]=max(0,currIssued[j]-temp[j])
				writeRecord(rfID,tobeIssued,currIssued,groupNo)
		if(val!="0"):
			data = findAllRecords()
			for rfID in data:
				tobeIssued=data[rfID][0]
				currIssued=data[rfID][1]
				groupNo=data[rfID][2]
				if groupNo!=int(val):
					continue
				for j in range(0,count):
					currIssued[j]=max(0,currIssued[j]-temp[j])
				writeRecord(rfID,tobeIssued,currIssued,groupNo)
	
	return

def professor():
	val=0
	while (1):
		print("1->Increment Weekly issues")
		print("2->Add items")
		print("3->Update returned Items")
		print("4->Exit")
		val=int(input())
		if val==1:
			setIssueValues(3)
		if val==2:
			print("Add number of items to be inserted")
			count=int(input()) # INPUT THE NUMBER OF ITEMS TO BE ADDED #
			servo.openDoor()
			for i in range(0,count):
				addItem()
				pass # OPTIONALLY WAIT FOR 4-5s #
			time.sleep(5)
			servo.closeDoor()
		if val==3:
			returnItems(3) 
		if val==4:
			break
			
	return


def menu():
	val=0
	while(4):
		print("1->Student")
		print("2->Instructor")
		print("3->Exit")
		
		val= int(input())
		
		if val==1:
			rfID = readRFID()
			issueItems(rfID)
		if val==2:
			print("Enter Password: ")
			password=int(input())
			if password != PASSWORD:
				continue
			professor()
			
		if val==3:
			break
			
	return
	

menu()
