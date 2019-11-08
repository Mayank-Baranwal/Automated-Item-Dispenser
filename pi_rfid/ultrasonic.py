#Libraries
import RPi.GPIO as GPIO
import time
#GPIO.setwarnings(False)
    

def distance():
	#GPIO Mode (BOARD / BCM)
	GPIO.setmode(GPIO.BCM)

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


    # time difference between start and arrival
	TimeElapsed = StopTime - StartTime
    # multiply with the sonic speed (34300 cm/s)
    # and divide by 2, because there and back
	distance = (TimeElapsed * 34300) / 2

	return distance

def foo():
	
	#GPIO Mode (BOARD / BCM)
	GPIO.setmode(GPIO.BCM)

	#set GPIO Pins
	GPIO_TRIGGER = 23
	GPIO_ECHO = 24

	#set GPIO direction (IN / OUT)
	GPIO.setup(GPIO_TRIGGER, GPIO.OUT)
	GPIO.setup(GPIO_ECHO, GPIO.IN)

	try:
		item_dispatched = False
		item_picked = False
		
		for _ in range(0,100):
			dist = distance()
			print ("Measured Distance = %.1f cm" % dist)
			
			if dist < 20:
				item_dispatched = True
			elif item_dispatched :
				item_picked = True
				return 2
				
			time.sleep(1)

		return item_dispatched
		
		
	# Reset by pressing CTRL + C
	except KeyboardInterrupt:
		print("Measurement stopped by User")
	finally:
		GPIO.cleanup()

foo()
