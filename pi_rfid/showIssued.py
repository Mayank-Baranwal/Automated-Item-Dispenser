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

fileName = "database.txt"
PASSWORD=5

item = {
	"WHITE" : "BreadBoard",
	"GREEN": "IC 781",
	"BLUE": "LED Strip",
}


''' TODO: To add item here '''
def addItem():
	print("Scan item in front of colour sensor")
	time.sleep(2) # Wait for 2 seconds #
	addedItem = color.getColour()
	pass # INCREMENT COUNT HERE #
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

def writeRecord(rfID ,toBeIssued, currIssued):
	data = findAllRecords()
	data[rfID] = [toBeIssued, currIssued]
	
	with open(fileName,'w') as f:
		json.dump(data,f)
		
	return
	
def readRecord(rfID):
	data = findAllRecords()
	return data[rfID]

def issueItems(rfID):
	tobeIssued, currIssued = readRecord(rfID)
	issueNext = True
	for i,itemCount in enumerate(tobeIssued):
		if(itemCount <= 0):
			continue
		
		for _ in range(0,itemCount):
			pass # Call for a rotation #
			pass # Check for Proximity Sensor #
			# IF PROXIMITY Doesn't reply in 10s CALL FAILURE #
			status = ultrasonic.foo()
			#status = 2
			if status == 0:
				print('Could not dispense item!')
				issueNext = False
				break
			elif status == 1:
				print('Item dipensed but not picked up!')
				tobeIssued[i] -= 1
				currIssued[i] += 1
				issueNext = False
				break
			else:
				print("Issued item " , str(i) )
				tobeIssued[i] -= 1
				currIssued[i] += 1
				time.sleep(2)
	
		if not issueNext: break
	print("Pending Issues: " , tobeIssued)
	print("Current Issued: " , currIssued)
	writeRecord(rfID,tobeIssued,currIssued)
	return
	
def setIssueValues(count):
	tobeIssued = []
	for i in range(0,count):
		print("Enter Count for item" , i) 
		val= int(input())
		tobeIssued.append(val)
	
	currIssued = [0] * count
	
	data = findAllRecords()
	for rfID in data:
		writeRecord(rfID,tobeIssued,currIssued)
	
	return
	

def professor():
	val=0
	while (1):
		print("1->Increment Weekly issues")
		print("2->Add items")
		print("3->Exit")
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
			break
			
	return

def menu():
	val=0
	while(4):
		print("1->Student")
		print("2->Instructor")
		print("3->Exit")
		#later change to matrix keypad
		
		val= int(input())
		
		if val==1:
			#student
			rfID = readRFID()
			issueItems(rfID)
		if val==2:
			#professor
			#later change to matrix keypad
			
			print("Enter Password: ")
			password=int(input())
			if password!=PASSWORD:
				continue
			professor()
			#open lock
			
		if val==3:
			break
			
	return

menu()
