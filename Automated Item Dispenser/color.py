import RPi.GPIO as GPIO
import time



s2 = 27
s3 = 22
signal = 17
NUM_CYCLES = 10

def setup():
	GPIO.setmode(GPIO.BCM)
	GPIO.setwarnings(False)
	GPIO.setup(signal,GPIO.IN, pull_up_down=GPIO.PUD_UP)
	GPIO.setup(s2,GPIO.OUT)
	GPIO.setup(s3,GPIO.OUT)

def getRGB():
	GPIO.output(s2,GPIO.LOW)
	GPIO.output(s3,GPIO.LOW)
	time.sleep(0.01)
	start = time.time()
	for impulse_count in range(NUM_CYCLES):
		GPIO.wait_for_edge(signal, GPIO.FALLING)
	duration = time.time() - start      #seconds to run for loop
	red  = NUM_CYCLES / duration   #in Hz
	# print("red value - ",red)

	GPIO.output(s2,GPIO.LOW)
	GPIO.output(s3,GPIO.HIGH)
	time.sleep(0.01)
	start = time.time()
	for impulse_count in range(NUM_CYCLES):
		GPIO.wait_for_edge(signal, GPIO.FALLING)
	duration = time.time() - start
	blue = NUM_CYCLES / duration
	# print("blue value - ",blue)

	GPIO.output(s2,GPIO.HIGH)
	GPIO.output(s3,GPIO.HIGH)
	time.sleep(0.01)
	start = time.time()
	for impulse_count in range(NUM_CYCLES):
		GPIO.wait_for_edge(signal, GPIO.FALLING)
	duration = time.time() - start
	green = NUM_CYCLES / duration
	
	#print(red,blue,green)
    
	return (red,green,blue)



def getColour():
	setup()
	r,g,b = (0,0,0)
	
	samples = 20
	for x in range(samples):
		k,l,m = getRGB()
		r += k
		g += l
		b += m
		
	r = r/samples 
	b = b/samples
	g = g/samples
	
	
	endprogram()
	maxColor = max(r,g,b)
	
	#print("Final Readings:",r,g,b)
	
	if( maxColor < 3000 ):
		return "NOTHING"
		
		
	if(maxColor == r):
		return "RED"
	elif(maxColor == b):
		return "BLUE"
	else:
		return "GREEN"

def endprogram():
    GPIO.cleanup()


if __name__ == '__main__':
	while(1):
		print(getColour())
