cpu "8085.tbl"
hof "int8"

org 9000h

GTHEX: EQU 030EH
OUTPUT:EQU 0389H

CURDT: EQU 8FF1H
UPDDT: EQU 044cH
CURAD: EQU 8FEFH
UPDAD: EQU 0440H

MVI A,00H
MVI B,00H


LXI H,0000H
SHLD 8840H
SHLD 8842H

LXI H,8840H
CALL OUTPUT ; initially display 0000 on address field

MVI A,00H
MVI B,00H
CALL GTHEX ; Taking input into D-E pair
MOV H,D
MOV L,E

;Checking for valid input
FIRST:
	MOV A,H
	CPI 12H ;check if hh is less than 12
	JC SECOND 
	
JMP TIMER ; if invalid input

SECOND:
	MOV A,L
	CPI 60H ; check if mm is less than 60 
	SHLD CURAD
	MVI A,99H
	STA CURDT
	JC NXT_SEC
	
JMP TIMER

TIMER:
	LXI H, 0000H
	MVI A, 99H 
	SHLD CURAD
	STA CURDT



NXT_SEC:
	LHLD CURAD
	LDA CURDT
	INR A ;next second
	DAA ; increments hex values with 6 to coonvert to decimal
	CPI 60H
	JNZ ONE
		MVI A, 00H
		STA CURDT
		MOV A, L
		INR A
		DAA
		MOV L, A
		CPI 60H ; compare if minute value has reached 60
		JNZ TWO
			MVI L, 00H ; if mm=60 change it to 00
			MOV A, H
			INR A
			DAA
			MOV H, A
			CPI 12H ;compare if hh has reached 12
			JZ TIMER ;compare if hh has reached 12
			JMP TWO

	ONE:
	STA CURDT ; store ss at curdt
	TWO:
	SHLD CURAD ;store hh and mm at curad
	CALL UPDDT ;print function
	CALL UPDAD
	CALL DELAY ; to cause delay of 1 s
	JMP NXT_SEC


JMP OVER

;to cause delay of 1 s
DELAY:
	LXI H, 5D0FH
	LXI D, 0004H
	LOOP1:
		LOOP2:
			LOOP3:
				DCR L
				JNZ LOOP3
			DCR H
			JNZ LOOP2
		DCR E
		JNZ LOOP1
	RET

OVER: 
RST 5