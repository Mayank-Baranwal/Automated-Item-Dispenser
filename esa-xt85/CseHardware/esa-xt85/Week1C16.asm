cpu "8085.tbl"
hof "int8"

org 9000h

dcr a
jz ADD
dcr a
; jz SUB
; dcr a
; jz MUL
; dcr a
; jz DIV

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

OVER:
RST 5