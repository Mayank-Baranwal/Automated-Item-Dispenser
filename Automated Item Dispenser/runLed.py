
import RPi.GPIO as GPIO
import time

bits = [10,12]

GPIO.setmode(GPIO.BOARD)
#GPIO.setwarnings(False)
GPIO.setup(bits[1],GPIO.OUT)
GPIO.setup(bits[0],GPIO.OUT)
	
GPIO.output(bits[1],GPIO.HIGH)
GPIO.output(bits[0],GPIO.HIGH)

time.sleep(5)

GPIO.output(bits[1],GPIO.LOW)
GPIO.output(bits[0],GPIO.LOW)
	
GPIO.cleanup()

