cpu "8085.tbl"
hof "int8"
org 9000h

GTHEX: EQU 030EH
OUTPUT:EQU 0389H

; Defining these standard special addresses
CURDT: EQU 8FF1H
UPDDT: EQU 044cH
CURAD: EQU 8FEFH
UPDAD: EQU 0440H

MVI A,00H
MVI B,00H


LXI H,8840H
MVI M,00H

LXI H,8841H
MVI M,00H


LXI H,8842H
MVI M,00H

LXI H,8843H
MVI M,00H

LXI H,8840H
CALL OUTPUT

MVI A,00H
MVI B,00H
CALL GTHEX ; Taking input into D-E pair
MOV H,D
MOV L,E

;Checking for valid input
FIRST:
	MOV A,H
	CPI 24H
	JC SECOND 
	
START:
	MVI H,00H ; If not valid, reset it with 0
	JC LOOP               
SECOND:
	MOV A,L
	CPI 60H
	JC LOOP
	
THIRD:
	MVI L,00H 	; If not valid, reset it with 0
	

LOOP:

HR_MIN:
	SHLD CURAD 
	MVI A,00H; Starting second counter with 0
NXT_SEC:
	STA CURDT
	CALL UPDAD
	CALL UPDDT 
	CALL DELAY
	LDA CURDT 
	ADI 01H ; Add 1
	DAA ; DAA adds 6 to all hexadecimal digits . so that 1a gets changed to 20 ,hence maintaining 
		; decimal number system
	CPI 60H ; While seconds<60 , loop and add 1
	JNZ NXT_SEC
	LHLD CURAD
	MOV A,L
	ADI 01H
	DAA
	MOV L,A
	CPI 60H ; While minutes<60 , loop and add 1
	JNZ HR_MIN
	MVI L,00H
	MOV A,H
	ADI 01H
	DAA
	MOV H,A
	CPI 24H ; While hours<24 , loop and add 1
	JNZ HR_MIN
	LXI H,0000H
	JMP LOOP

; Delay introduces a delay of 1 second
DELAY:
	MVI C,03H
OUTLOOP:
	LXI D,9F00H
INLOOP:
	DCX D 
	MOV A,D
	ORA E 
	JNZ INLOOP
	DCR C
	JNZ OUTLOOP
	RET
RST 5