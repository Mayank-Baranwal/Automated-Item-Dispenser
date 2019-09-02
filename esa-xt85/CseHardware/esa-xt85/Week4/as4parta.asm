cpu "8085.tbl"
hof "int8"

org 9000h 

MVI A,8BH
OUT 43H

BEGIN:	
	CALL FINCHECK   ;Check if 2nd dip switch is high, if high then terminate.
	IN 41H
	ANI 004H   		
	CPI 00H
	JZ CONT         ;Check if 6th switch is high, if yes increment count else repeat.
	JMP BEGIN
	RST 5
;In this function we will simply increment the count and between every iteration we will check for 5th and second switch.

CONT:
	MVI A,80H            
	OUT 40H
	CALL DELAY
	MVI A,40H
	OUT 40H
	CALL DELAY
	MVI A,20H
	OUT 40H
	CALL DELAY
	MVI A,10H
	OUT 40H
	CALL DELAY
	MVI A,08H
	OUT 40H
	CALL DELAY
	MVI A,04H
	OUT 40H
	CALL DELAY
	MVI A,02H
	OUT 40H
	CALL DELAY
	MVI A,01H
	OUT 40H
	CALL DELAY
	JMP CONT

;Checking D2
FINCHECK:
	IN 41H
	ANI 040H
	CPI 00H
	JZ TERMINATE
	RET

;Check d5 and d2, if both low then we will delay and return.
DELAY:

CALL PAUSECHECK
CALL FINCHECK
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


TERMINATE:
	MVI A, 00H
	OUT 40H
	RST 5


PAUSECHECK:
	CALL FINCHECK
	IN 41H
	MOV D,A
	ANI 008H
	CPI 00H
	JNZ BACK
	CALL INF

	BACK:
	MOV A,D
	RET

INF:
	CALL FINCHECK
	IN 41H
	MOV D,A
	ANI 008H
	CPI 00H
	JZ INF

	MOV A,D
	ANI 004H
	CPI 00H
	JNZ INF
	RET