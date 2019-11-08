import RPi.GPIO as GPIO
import time


control_pins = [3,5,7,8]
  
halfstep_seq = [
  [1,0,0,0],
  [1,1,0,0],
  [0,1,0,0],
  [0,1,1,0],
  [0,0,1,0],
  [0,0,1,1],
  [0,0,0,1],
  [1,0,0,1]
]

halfstep_seq.reverse()


def rotateMotor(numRotations):
	try:
		setup()
		for _ in range(numRotations):
			oneRotation()
	finally:
		cleanup()
	
	


def setup():
	GPIO.setmode(GPIO.BOARD)
	for pin in control_pins:
		GPIO.setup(pin, GPIO.OUT)
		GPIO.output(pin, 0)
	
def oneRotation():
	for _ in range(525):
		for halfstep in range(8):
			for pin in range(4):
				GPIO.output(control_pins[pin], halfstep_seq[halfstep][pin])
			time.sleep(0.001)
	
def cleanup():
	GPIO.cleanup()


# rotateMotor(5)
