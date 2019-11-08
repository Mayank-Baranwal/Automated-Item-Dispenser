#!/usr/bin/env python

import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)
GPIO.setup(10,GPIO.OUT)
GPIO.setup(12,GPIO.OUT)
GPIO.setup(26,GPIO.OUT)



GPIO.output(10,1)
GPIO.output(12,1)
GPIO.output(26,1)


#GPIO.cleanup()
