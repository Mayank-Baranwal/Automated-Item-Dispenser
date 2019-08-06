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
dcr a
jz ORR

ADD:
	lxi h, 8840H
	mov e,m
	inx h
	mov c,m
	mvi b, 00H
	mvi d, 00H

	lxi h, 0000H
	dad b
	dad d

	mov a, l
	sta 8900H
	mov a, h
	sta 8901H
	jmp OVER

SUB:
	lxi h, 8840H
	mov a,m
	inx h
	mov b,m
	sub b
	sta 8900H
	jmp OVER

MUL:
	lxi h, 8840H
	mov e, m
	inx h
	mov b, m
	mvi d, 00H
	lxi h, 0000H

	LOOP:
		dad d
		dcr b
		jnz LOOP

	mov a, l
	sta 8900H
	mov a, h
	sta 8901H

	jmp OVER

DIV:
	lxi h, 8840H
	mov a, m
	inx h
	mov b, m
	mvi c, 00H

	LOOP2:
		cmp b
		jc STR
		sub b
		inr c
		jmp LOOP2

	STR:
		sta 8900H
		mov a,c
		sta 8901H

	jmp OVER

ORR:
	lxi h, 8840H
	mov a, m
	inx h
	mov b, m
	ora b
	sta 8900H
	jmp OVER


OVER:
	RST 5