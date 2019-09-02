Group 11 Week 3 README:

Aim: Part a) Blink LED's cyclicly with a delay of 1s in between
     Part b) Design a game where 2 random LED's light up and user has to match those LED's


Extra:  - 3rd Level of game IMPLEMENTED where we have to light up the complement of Lights lighting up 
 	
Group members:
a) Hardik Katyal - 170101026 
b) Kartik Gupta - 170101030
c) Udbhav Chugh - 170101081
d) Mayank Baranwal -170101084

Google Drive Docs Overview:
a) "as4parta.asm" file: Blink LED's cyclicly
b) "as4partb.asm" file: Angry Birds Game
All files have associated assembled .hex and .lst files as well

Steps to Load Files on 8085:
a) Download files and place in same folder as "xt85" application and setup the 8085 board
b) Assembly: Pre-assembled .hex and .lst files provided
c) Open the "xt85" application with 8085 board in "Serial" mode (4th switch to the right)
d) Press Ctrl+D twice, enter file name and transfer file to 8085 board
e) Change 4th switch on 8085 board back to the left

Program Execution (Post Loading Files):
a) "as4parta.asm" - Blink LED's cyclicly
	i)   Press "GO", enter "9000" and press "EXEC" to run program
	ii)  Assign Low to D2 to Terminate, D5 to Pause and D6 to Start. 


b) "as4partb.asm" - Angry Birds Game with EXTRA 3rd Level
	i)   Press EXAM_MEM and then enter the Seed at the location 8200H and 8201H
	ii)  Press "GO", enter "9000" and press "EXEC" to run program
	iii) For Level 0: Two Random LED's will lightup, Match the LED's within a short time to increase score
	iv)  For Level 1: Two Random LED's will lightup, Match the LED's within a shorter time to increase score. ( Waiting time is less than Level 0 )
	v)   For Level 2: Any number of Random LED's will lightup. Light the complement of those to increase your score. 


