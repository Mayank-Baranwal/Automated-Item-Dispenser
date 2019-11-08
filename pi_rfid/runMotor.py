import RPi.GPIO as GPIO
import time
import stepperMotor

bits = [10,12]

def runMotor(whichMotor, numRotations):
	#print("reached here")
	GPIO.setmode(GPIO.BOARD)
	GPIO.setwarnings(False)
	GPIO.setup(bits[0],GPIO.OUT)
	GPIO.setup(bits[1],GPIO.OUT)
	lowerBit = (whichMotor & 1)
	higherBit = (whichMotor//2  & 1)
	
	print(lowerBit,higherBit)
	
	lowerOutput = GPIO.HIGH
	higherOutput = GPIO.HIGH
	if(lowerBit == 0):
		lowerOutput = GPIO.LOW
	
	if(higherBit == 0):
		higherOutput = GPIO.LOW
		
	print(lowerOutput,higherOutput)
	
	
	GPIO.output(bits[0],lowerOutput)
	GPIO.output(bits[1],higherOutput)
	#time.sleep(1000)
	
	stepperMotor.rotateMotor(numRotations)
	GPIO.setmode(GPIO.BOARD)
	GPIO.setwarnings(False)
	GPIO.setup(bits[0],GPIO.OUT)
	GPIO.setup(bits[1],GPIO.OUT)
	GPIO.output(bits[0],GPIO.LOW)
	GPIO.output(bits[1],GPIO.LOW)
	GPIO.cleanup()

#print("Going in the function!")
runMotor(2,1000)
