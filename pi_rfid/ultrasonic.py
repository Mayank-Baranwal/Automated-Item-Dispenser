#Libraries
import RPi.GPIO as GPIO
import time
#GPIO.setwarnings(False)
    

def distance():
	GPIO.setmode(GPIO.BCM)
	GPIO.setwarnings(False)

	#set GPIO Pins
	GPIO_TRIGGER = 23
	GPIO_ECHO = 24

	#set GPIO direction (IN / OUT)
	GPIO.setup(GPIO_TRIGGER, GPIO.OUT)
	GPIO.setup(GPIO_ECHO, GPIO.IN)
	
    # set Trigger to HIGH
	GPIO.output(GPIO_TRIGGER, True)

    # set Trigger after 0.01ms to LOW
	time.sleep(0.00001)
	GPIO.output(GPIO_TRIGGER, False)

	StartTime = time.time()
	StopTime = time.time()
    # save StartTime
	while GPIO.input(GPIO_ECHO) == 0:
		StartTime = time.time()

    # save time of arrival
	while GPIO.input(GPIO_ECHO) == 1:
		StopTime = time.time()

	TimeElapsed = StopTime - StartTime
	
    # multiply with the sonic speed (34300 cm/s)
    # and divide by 2, because there and back
    
	distance = (TimeElapsed * 34300) / 2

	return distance

def foo():

	try:
		item_dispatched = False
		item_picked = False
		toReturn = 0
		for _ in range(0,25):
			dist = distance()
			
			#print ("Measured Distance = %.1f cm" % dist)
			
			if(dist > 22):
				time.sleep(0.4)
				continue	
			
			if dist < 15:
				item_dispatched = True
				toReturn = 1
				#for temp in range(8):
				#	time.sleep(0.4)
				#	dist = distance()
				#time.sleep(1)
			elif item_dispatched :
				item_picked = True
				toReturn = 2
				#return 2
				
			time.sleep(0.4)

		return toReturn
		
		
	# Reset by pressing CTRL + C
	except KeyboardInterrupt:
		print("Measurement stopped by User")
		#GPIO.cleanup()
		#exit(0)
	finally:
		GPIO.cleanup()

if __name__ == "__main__":
	while(4):
		foo()
		time.sleep(0.1)
