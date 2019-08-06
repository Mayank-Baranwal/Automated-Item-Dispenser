cpu "8085.tbl"
hof "int8"

org 9000h

dcr a
jz ADD
dcr a
jz SUB
dcr a
jz MUL
dcr a
jz DIV

ADD:
	lxi h, 8840H
	mov e,m
	inx h
	mov d,m
	inx h
	mov c,m
	inx h
	mov b,m
	lxi h, 0000h
	dad b
	mvi b,00H
	dad d
	; xchg
	jnc NOCAR
	mvi b,01H
	NOCAR:
	mov a,l
	sta 8900h
	mov a,h
	sta 8901h
	mov a,b
	sta 8902h
	jmp OVER

SUB:
	LHLD 8840H
	XCHG
	LHLD 8842H
	MOV A, E
	SUB L
	STA 8900H
	MOV A, D
	SBB H
	STA 8901H
	jmp OVER

MUL:
	LHLD 8840h
	SPHL
	LHLD 8842h
	XCHG
	LXI H, 0000H
	LXI B, 0000H
	LBL2:
	DAD SP
	JNC LBL
	INX B
	LBL:
	DCX D
	MOV A, E
	ORA D
	JNZ LBL2
	SHLD 8900h
	MOV L, C
	MOV H, B
	SHLD 8902h
	jmp OVER

DIV:
	LXI B, 0000H
	LHLD 8840h
	XCHG
	LHLD 8842h
	LBL2:
	MOV A, L
	SUB E
	MOV L, A
	MOV A, H
	SBB D
	MOV H, A
	JC LBL
	INX B
	JMP LBL2
	LBL:
	DAD D
	SHLD 8900h
	MOV L, C
	MOV H, B
	SHLD 8902h
	jmp OVER

OVER:
RST 5