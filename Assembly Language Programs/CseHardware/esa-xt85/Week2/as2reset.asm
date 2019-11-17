cpu "8085.tbl"
hof "int8"

org 9000h

CURDT: EQU 8FF1H
UPDDT: EQU 044cH
CURAD: EQU 8FEFH
UPDAD: EQU 0440H
OUTPUT:EQU 0389H


TIMER: ; Reset the clock to 00:00 ; 
	LXI H, 0000H
	MVI A, 99H 
	SHLD CURAD
	STA CURDT

NXT_SEC: ; Increment the time by 1s ; 
	LHLD CURAD
	LDA CURDT
	INR A
	DAA
	MVI B,60H
	CMP B
	JNZ ONE ; If Seconds == 60 increment Minutes ;  
		MVI A, 00H
		STA CURDT
		MOV A, L
		INR A
		DAA
		MOV L, A
		MVI B,60H
		CMP B
		JNZ TWO ; If Minutes == 60 increment Hours ; 
			MVI L, 00H
			MOV A, H
			INR A
			DAA
			MOV H, A
			MVI B,12H
			CMP B ; If Hours == 12 Reset to 0 ; 
			JZ TIMER
			JMP TWO

	ONE:
	STA CURDT
	TWO:
	SHLD CURAD

	LDA 8840H ; load ss of alarm
	MOV B,A
	LDA CURDT
	CMP B
	JNZ THREE ; if ss not equal move normally
	LHLD CURAD 
	LDA 8841H ; load mm of alarm
	CMP L 
	JNZ THREE ; if mm not equal move normally
	LDA 8842H ; load hh of alarm
	CMP H 
	JNZ THREE ; if hh not equal move normally

	JMP TIMER ; if alarm reached reset clock

	THREE: 
	CALL UPDDT
	CALL UPDAD
	CALL DELAY
	JMP NXT_SEC


JMP OVER

DELAY: ; Delay the clock by 1s ; 
	LXI H, 540FH
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