
import RPi.GPIO as GPIO
import time
import stepperMotor

motorPin = [10,12,26]

def runMotor(whichMotor, numRotations):
	try: 
		GPIO.setmode(GPIO.BOARD)
		GPIO.setwarnings(False)
		
		for x in motorPin:
			GPIO.setup(x,GPIO.OUT)
			GPIO.output(x,GPIO.LOW)
		
		GPIO.output(motorPin[whichMotor],GPIO.HIGH)
		
		
		stepperMotor.rotateMotor(numRotations)
	except:
		pass
	finally:
		GPIO.setmode(GPIO.BOARD)
		GPIO.setwarnings(False)
		
		for x in motorPin:
			GPIO.setup(x,GPIO.OUT)
			GPIO.output(x,GPIO.LOW)
			
		GPIO.cleanup()
		


if __name__ == "__main__":
	runMotor(0,1)
	



