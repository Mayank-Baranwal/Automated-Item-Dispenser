;program 2: 16 bit calculator

cpu "8085.tbl"
hof "int8"

org 9000h ;origin address of program at 9000h

;a=1 indicates addition
dcr a
jz ADD
;a=2 indicates subtraction
dcr a
jz SUB
;a=3 indicates multiplication
dcr a
jz MUL
;a=4 indicates division
dcr a
jz DIV
;if(a>4) simply go to end of file
jmp OVER

ADD:
	lxi h, 8840H
	mov e,m ; load lower 8 bits of first number to register e from location 8840h
	inx h
	mov d,m ; load higher 8 bits of first number to register d from location 8841h
	inx h
	mov c,m ; load lower 8 bits of second number to register e from location 8842h
	inx h
	mov b,m ; load higher 8 bits of second number to register d from location 8843h
	lxi h, 0000h ; intialise hl with 0000h
	dad b ; add bc to hl
	mvi b,00H ; b stores carry if any(17th bit)
	dad d ; add de to hl
	; xchg
	jnc NOCAR 
	mvi b,01H ; if carry make b as 01h
	NOCAR:
	mov a,l
	sta 8900h ; store lower 8 bits of answer in location 8900h
	mov a,h
	sta 8901h ; store higher 8 bits of answer in location 8901h
	mov a,b
	sta 8902h ; ; store carry(if any) in location 8902h
	jmp OVER

SUB:
	LHLD 8840H ; load first number in h-l register pair from 8840h(lower 8 bits) and 8841h(higher 8 bits)
	XCHG ; swap content of d-e and h-l
	LHLD 8842H ; load second number in h-l register pair from 8842h(lower 8 bits) and 8843h(higher 8 bits)
	MOV A, E 
	SUB L ; E-L
	STA 8900H ; store lower 8 bits in location 8900h
	MOV A, D
	SBB H ; D-H(with borrow if any from previous)
	STA 8901H ; store higher 8 bits in location 8901h
	jmp OVER

MUL:
	LHLD 8840h ; load first number in h-l register pair from 8840h(lower 8 bits) and 8841h(higher 8 bits)
	SPHL ; push content of h-l in stack
	LHLD 8842h ; load second number in h-l register pair from 8842h(lower 8 bits) and 8843h(higher 8 bits)
	XCHG ; swap content of d-e and h-l
	LXI H, 0000H ;h-l stores lower 16 bits of answer
	LXI B, 0000H ; b-c stores higher 16 bits of answer
	;add content of stack d-e times
	LBLMUL2:
	DAD SP
	JNC LBLMUL 
	INX B ; increment b-c if carry from h-l
	LBLMUL:
	DCX D ; decrement d-e after every iteration
	MOV A, E
	ORA D ; d or e to check if d-e is 0 or not
	JNZ LBLMUL2 ; loop again if d-e not zero
	; b-c-h-l is the final answer
	SHLD 8900h ; store lower 16 bits in 8900h(lower 8 bits) and 8901h(higher 8 bits)
	MOV L, C
	MOV H, B
	SHLD 8902h ; store higher 16 bits in 8902h(lower 8 bits) and 8903h(higher 8 bits)
	jmp OVER

DIV:
	LXI B, 0000H 
	LHLD 8842h ; load first number(dividend) in h-l register pair from 8842h(lower 8 bits) and 8843h(higher 8 bits)
	XCHG ; swap content of d-e and h-l
	LHLD 8840h ; load second number(divisor) in h-l register pair from 8840h(lower 8 bits) and 8841h(higher 8 bits)
	LBL2:
	MOV A, L 
	SUB E ; l-e
	MOV L, A ; store l-e in l
	MOV A, H
	SBB D ; h-d (with borrow if any)
	MOV H, A ; store h-d in h
	JC LBL ; if carry triggered it means de>hl and we need to end
	INX B ; else increment quotient
	JMP LBL2 ; loop back to LBL2
	LBL:
	DAD D ; we need to add de since an extra subtraction will be done in the last iteration of loop
	SHLD 8900h ; h-l stores remainder and it is moved to location 8900h(lower 8 bits) and 8901h(higher 8 bits)
	MOV L, C
	MOV H, B
	SHLD 8902h ; ; b-c stores quotient and it is moved to location 8902h(lower 8 bits) and 8903h(higher 8 bits)
	jmp OVER

OVER:
RST 5