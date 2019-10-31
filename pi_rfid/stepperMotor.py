import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)
control_pins = [3,5,7,8]

for pin in control_pins:
  GPIO.setup(pin, GPIO.OUT)
  GPIO.output(pin, 0)
  
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

while(4):
	for halfstep in range(8):
		for pin in range(4):
			GPIO.output(control_pins[pin], halfstep_seq[halfstep][pin])
		time.sleep(0.001)
	
	
	
GPIO.cleanup()
