import RPi.GPIO as GPIO
import time

#control = [5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10]
control = [7.5, 3]


servo = 5

# in servo motor,
# 1ms pulse for 0 degree (LEFT)
# 1.5ms pulse for 90 degree (MIDDLE)
# 2ms pulse for 180 degree (RIGHT)

# so for 50hz, one frequency is 20ms
# duty cycle for 0 degree = (1/20)*100 = 5%
# duty cycle for 90 degree = (1.5/20)*100 = 7.5%
# duty cycle for 180 degree = (2/20)*100 = 10%



def setup():
	GPIO.setmode(GPIO.BCM)
	GPIO.setup(servo,GPIO.OUT)
	p=GPIO.PWM(servo,50)# 50hz frequency
	p.start(5)# starting duty cycle ( it set the servo to 0 degree )
	return p


def endProgram():
	GPIO.cleanup()
	returO.PWM(servo,50)# 50hz frequency
	p.start(0)# starting duty cycle ( it set the servo to 0 degree )
	return p


def endProgram():
	GPIO.cleanup()
	return


def closeDoor():
	try:
		p=setup()
		for x in range(1):
			p.ChangeDutyCycle(control[x])
			time.sleep(2)
	finally:
		endProgram()
	return


def openDoor():
	try:
		p=setup()
		for x in range(1,2):
			p.ChangeDutyCycle(control[x])
			time.sleep(2)
	finally:
		endProgram()
	return


if __name__ == "__main__":
	#for _ in range(5):
	openDoor()
	closeDoor()
