Group 11 Week 2 README:

Aim: Create a 12 hr clock.
Extra:  - 12 hr clock with user input
	- 24 hr clock with user input
	- 12 hr clock with reset Alarm
	- 12 hr clock with multiple alarms and message on each alarm 
 	
Group members:
a) Hardik Katyal - 170101026 
b) Kartik Gupta - 170101030
c) Udbhav Chugh - 170101081
d) Mayank Baranwal -170101084

Google Drive Docs Overview:
a) "AS2ip12.asm" file: Displays 12 hr clock starting at user input.
b) "AS2ip24.asm" file: Displays 24 hr clock starting at user input.
c) "AS2reset.asm" file : 12 hr clock resets when alarm is encountered.
d) "AS2alarm.asm" file : Stores multiple alarms and displays 'ABCDEF' when any alarm is triggered.
All files have associated assembled .hex and .lst files as well

Steps to Load Files on 8085:
a) Download files and place in same folder as "xt85" application and setup the 8085 board
b) Assembly: Pre-assembled .hex and .lst files provided
c) Open the "xt85" application with 8085 board in "Serial" mode (4th switch to the right)
d) Press Ctrl+D twice, enter file name and transfer file to 8085 board
e) Change 4th switch on 8085 board back to the left

Program Execution (Post Loading Files):
a) "AS2ip12.asm" - 12 hr clock
	i) Press "GO", enter "9000" and press "EXEC" to run program
	ii) Enter the start time of clock ( In HH:MM ) press NEXT, and clock will start from HH:MM:00 .


b) "AS2ip24.asm" - 24 hr clock
	i) Press "GO", enter "9000" and press "EXEC" to run program
	ii) Enter the start time of clock ( In HH:MM ) press NEXT, and clock will start from HH:MM:00 .

c) "AS2reset.asm" - 12 hr clock with reset Alarm
	i) Load alarm in locations 8842,8841 and 8840. Load SS in memoryy location 8840, MM in memory location 8841 and HH in memoryy location 8842. 
	ii) Press "GO", enter "9000" and press "EXEC" to run program.
	ii) The clock ticks in 12 hr format and reset to 00:00:00 when alarm time is reached.

d) "AS2alarm.asm" - 12hr clock with multiple alarms
	i) Load number of alarms in 8840 memory location. 
	(Alarms are named alarm 0 to alarm n-1)
	ii) For ith alarm load SS in memory location 8841+(i*3), load MM in memory location 8842+(i*3) and load HH in memory location 8843+(i*3).
	iii) Press "GO", enter "9000" and press "EXEC" to run program.
	iv) The clock ticks in 12 hr format and dislays 'ABCDEF' when any of the alarms is encounterd and continues normally from there.
	 