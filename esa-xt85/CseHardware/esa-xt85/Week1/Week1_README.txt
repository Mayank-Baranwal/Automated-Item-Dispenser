Group 11 Week 1 README:

Aim: Create a 8-bit and 16-bit calculator to perform addition, subtraction, multiplication, division for 8-bit and 16-bit numbers
Extra: 8-bit calculator performs OR operation
	
Group members:
a) Hardik Katyal - 170101026 
b) Kartik Gupta - 170101030
c) Udbhav Chugh - 170101081
d) Mayank Baranwal -170101084

Google Drive Docs Overview:
a) "AS1BIT8.asm" file: Performs 8-bit addition, subtraction, multiplication, division and xor
b) "AS1BIT16.asm" file: Performs 8-bit addition, subtraction, multiplication and division
All files have associated assembled .hex and .lst files as well

Steps to Load Files on 8085:
a) Download files and place in same folder as "xt85" application and setup the 8085 board
b) Assembly: Pre-assembled .hex and .lst files provided
c) Open the "xt85" application with 8085 board in "Serial" mode (4th switch to the right)
d) Press Ctrl+D twice, enter file name and transfer file to 8085 board
e) Change 4th switch on 8085 board back to the left

Program Execution (Post Loading Files):
a) AS1BIT8.asm - 8bit calculator
	i) Enter value in register A for choosing operation (01-Addition, 02-Subtraction, 03-Multiplication, 04-Division, 05-OR)
	ii) Load operand 1 (op1) in memory 8840 and operand 2 (op2) in memory 8841 (Note: For subtraction and division, calculator performs op1-op2, op1/op2 respectively)
	iii) Press "GO", enter "9000" and press "EXEC" to run program
	iv) Results of program are displayed in memory 8900 onwards in Little Endian format

	Note: 	Addition result may be 9bit in nature (check both 8900 and 8901 memory locations)
		Multiplication result may 16bit in nature (check both 8900 and 8901 memory locations)
		Division result - 8900: Remainder;	 8901: Quotient	
		OR and Subtraction results are 8bit in nature (check only 8900 memory)

b) AS1BIT16.asm - 16bit calculator
	i) Enter value in register A for choosing operation (01-Addition, 02-Subtraction, 03-Multiplication, 04-Division)
	ii) In Little Endian format, load operand 1 (op1) in memory 8840, 8841 (16bit) and operand 2 (op2) in memory 8842, 8843 (Note: For subtraction and division, calculator performs op1-op2, op1/op2 respectively)
	iii) Press "GO", enter "9000" and press "EXEC" to run program
	iv) Results of program are displayed in memory 8900 onwards in Little Endian format

	Note: 	Addition result may be 17bit in nature (check 8900, 8901, 8902 memory locations)
		Subtraction result is 16bit in anture (check 8900, 8901 memory locations)
		Multiplication result may 32bit in nature (check 8900, 8901, 8902, 8903 memory locations)
		Division result - 8900, 8901: Remainder;	 8902, 8903: Quotient 


Important: All results and inputs are in Little Endian format (lower 8bits present in first memory location followed by higher 8bits)