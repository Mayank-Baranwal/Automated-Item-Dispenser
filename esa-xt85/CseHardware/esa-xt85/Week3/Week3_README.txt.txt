Group 11 Week 3 README:

Aim: Create a 12 hr clock.
Extra:  - 12 hr up timer with user input, storing time of interrupts
	- 12 hr down timer with user input, storing time of interrupts
	- 24 hr down timer with user input, storing time of interrupts
 	
Group members:
a) Hardik Katyal - 170101026 
b) Kartik Gupta - 170101030
c) Udbhav Chugh - 170101081
d) Mayank Baranwal -170101084

Google Drive Docs Overview:
a) "AS3UP.asm" file: Displays 12 hr up timer starting at user input and storing time of interrupts.
b) "AS3DOWN.asm" file: Displays 12 hr down timer starting at user input and storing time of interrupts.
c) "AS3D24.asm" file : Displays 24 hr down timer starting at user input and storing time of interrupts.
All files have associated assembled .hex and .lst files as well

Steps to Load Files on 8085:
a) Download files and place in same folder as "xt85" application and setup the 8085 board
b) Assembly: Pre-assembled .hex and .lst files provided
c) Open the "xt85" application with 8085 board in "Serial" mode (4th switch to the right)
d) Press Ctrl+D twice, enter file name and transfer file to 8085 board
e) Change 4th switch on 8085 board back to the left

Program Execution (Post Loading Files):
a) "AS3UP.asm" - 12 hr up timer
	i)   Note the starting address where the code to be executed on interrupt starts and store that address on location 8FBF H in memory. (For this particular code note the address of line "PUSH PSW").
	ii)  Press "GO", enter "9000" and press "EXEC" to run program
	iii) Enter the start time of clock ( In HH:MM ) press NEXT, and clock will start from HH:MM:00 .
	iv)  Press interrupt key to pause the timer.*
	v)   Press any other key twice to start the timer again.

	* All the interrupt times are stored in memory in Little Endian format starting from 8802H.


b) "AS3DOWN.asm" - 12 hr down timer
	i)   Note the starting address where the code to be executed on interrupt starts and store that address on location 8FBF H in memory. (For this particular code note the address of line "PUSH PSW").
	ii)  Press "GO", enter "9000" and press "EXEC" to run program
	iii) Enter the start time of clock ( In HH:MM ) press NEXT, and clock will start from HH:MM:59 .
	iv)  Press interrupt key to pause the timer.*
	v)   Press any other key twice to start the timer again.

	* All the interrupt times are stored in memory in Little Endian format starting from 8802H.



c) "AS3D24.asm" - 24 hr down timer
	i)   Note the starting address where the code to be executed on interrupt starts and store that address on location 8FBF H in memory. (For this particular code note the address of line "PUSH PSW").
	ii)  Press "GO", enter "9000" and press "EXEC" to run program
	iii) Enter the start time of clock ( In HH:MM ) press NEXT, and clock will start from HH:MM:59 .
	iv)  Press interrupt key to pause the timer.*
	v)   Press any other key twice to start the timer again.

	* All the interrupt times are stored in memory in Little Endian format starting from 8802H.
