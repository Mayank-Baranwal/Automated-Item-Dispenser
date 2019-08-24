cpu "8085.tbl"
hof "int8"

org 9000h

GTHEX: EQU 030EH    		;Gets hex digits and displays them
HXDSP: EQU 034FH			;Expands hex digits for display
OUTPUT:EQU 0389H			;Outputs characters to display
CLEAR: EQU 02BEH			;Clears the display
RDKBD: EQU 03BAH			;Reads keyboard
KBINT: EQU 3CH	

CURDT: EQU 8FF1H
UPDDT: EQU 044cH
CURAD: EQU 8FEFH
UPDAD: EQU 0440H


LXI H,8802H
SHLD 8800H
LXI H,0000H
SHLD 8900H


MVI A, 0BH
SIM
EI

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
	MVI A,60H
	STA CURDT
	JC NXT_SEC
	
JMP TIMER

TIMER:
	LXI H, 1159H
	MVI A, 60H 
	SHLD CURAD
	STA CURDT



NXT_SEC:
	LHLD CURAD
	LDA CURDT
	CALL SUBTRACT_FUNCTION
	CPI 0F9H
	JNZ ONE
		MVI A, 59H
		STA CURDT
		MOV A, L
		CALL SUBTRACT_FUNCTION
		MOV L, A
		CPI 0F9H ; compare if minute value has reached 60
		JNZ TWO
			MVI L, 59H ; if mm=60 change it to 00
			MOV A, H
			CALL SUBTRACT_FUNCTION
			MOV H, A
			CPI 0F9H ;compare if hh has reached 12
			JZ OVER ;compare if hh has reached 12
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

PUSH PSW
PUSH H
MOV D,A
PUSH D

LDA 8900H
CPI 00H
JNZ LBL

LHLD 8800H
LDA CURDT
MOV M,A
INX H
LDA 8FEFH
MOV M,A
INX H
LDA 8FF0H
MOV M,A
INX H
SHLD 8800H



LBL:
LDA 8900H
XRI 01H
STA 8900H

CALL RDKBD

POP D
MOV A,D
POP H
MVI D,00H
POP PSW
EI
RET

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


SUBTRACT_FUNCTION:						;bcd subtractor 
 STA 8202H
 ANI 0FH
 CPI 00H
 JZ SUBTRACT_HELPER
 LDA 8202H
 DCR A
 RET
 SUBTRACT_HELPER:
 LDA 8202H
 SBI 07H
 RET


