from pad4pi import rpi_gpio
import time


class myKeypad:
	def __init__(self):
		self.KEYPAD = [
			["1","2","3","A"],
			["4","5","6","B"],
			["7","8","9","C"],
			["*","0","#","D"]
		]
		
		self.ROW_PINS = [21, 20, 26, 13] # BCM numbering
		self.COL_PINS = [16, 19, 12, 6] # BCM numbering
		
		self.buff = ""
		self.endOfInput = False
		self.factory = rpi_gpio.KeypadFactory()
		self.keypad = self.factory.create_keypad(keypad=self.KEYPAD, row_pins=self.ROW_PINS, col_pins=self.COL_PINS)
		self.keypad.registerKeyPressHandler(self.registerInput)
		#print("Object Created")
		return
	
	
	def returnInput(self):
		temp = self.buff
		self.buff = ""
		self.endOfInput = False
		print()
		return temp
	
	def registerInput(self,key):
		if(self.endOfInput):
			return 
		
		if(key == '*'):
			if(self.buff != ""):
				self.endOfInput = True
				return
			
		if(key == 'B'):
			self.buff = self.buff[0:-1]
			print("\b \b",end = "", flush=True)
			return
		
		print(key,end="",flush=True)
		self.buff += key
	
	def __del__(self):
		#print("Object Destroyed")
		self.keypad.cleanup()
		self.keypad.clearKeyPressHandlers()
		return 


''' Keypad k is not destructing '''
def input():
	kp = myKeypad()
	
	while(kp.endOfInput == False):
		pass
		
	ip = kp.returnInput()
	kp.__del__()
	#del kp
	
	return ip



input()
