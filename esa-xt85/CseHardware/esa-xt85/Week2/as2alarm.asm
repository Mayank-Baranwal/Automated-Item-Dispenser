cpu "8085.tbl"
hof "int8"

org 9000h

CURDT: EQU 8FF1H
UPDDT: EQU 044cH
CURAD: EQU 8FEFH
UPDAD: EQU 0440H
OUTPUT:EQU 0389H

LXI H,0FFFFH
SHLD 8900H

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
	MVI B,60H
	CMP B
	JNZ ONE
		MVI A, 00H
		STA CURDT
		MOV A, L
		INR A
		DAA
		MOV L, A
		MVI B,60H ; compare if minute value has reached 60
		CMP B
		JNZ TWO
			MVI L, 00H ; if mm=60 change it to 00
			MOV A, H
			INR A
			DAA
			MOV H, A
			MVI B,12H ;compare if hh has reached 12
			CMP B
			JZ TIMER ;compare if hh has reached 12
			JMP TWO

	ONE:
	STA CURDT ; store ss at curdt
	TWO:
	SHLD CURAD ;store hh and mm at curad
	LDA 8840H ;find count of alarms
	JZ THREE
	MOV C,A
	LXI D,8840H
	FOUR:

	INX D ;fetch alarm seconds
	XCHG
	MOV B,M
	XCHG
	LDA CURDT
	CMP B	;compare alarm secs with current secs
	JZ TEMP1
	INX D
	INX D
	JMP FIVE

	TEMP1:
	INX D ;fetch alarm minute
	XCHG
	MOV B,M
	XCHG
	LHLD CURAD
	MOV A,L
	CMP B ;compare alarm secs with current minute
	JZ TEMP2
	INX D
	JMP FIVE

	TEMP2:
	INX D ;fetch alarm hour
	XCHG
	MOV B,M
	XCHG
	LHLD CURAD
	MOV A,H
	CMP B ;compare alarm secs with current hour
	JNZ FIVE

	LDA CURDT
	STA 8900H
	LHLD CURAD
	SHLD 8901H
	MVI A,0EFH
	LXI H,0ABCDH
	STA CURDT
	SHLD CURAD
	CALL UPDDT ;print function
	CALL UPDAD
	CALL DELAY ; to cause delay of 1 s
	LDA 8900H
	LHLD 8901H

	STA CURDT
	SHLD CURAD
	; RST 5

	JMP THREE
	FIVE:
	DCR C
	JNZ FOUR

	
	; JMP TIMER
	THREE: 
	CALL UPDDT
	CALL UPDAD
	CALL DELAY
	JMP NXT_SEC


JMP OVER

DELAY:
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