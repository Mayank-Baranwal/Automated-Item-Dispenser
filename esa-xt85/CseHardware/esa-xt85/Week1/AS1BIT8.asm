;program 1: 8 bit calculator

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
;a=5 indicates OR operation (additional feature)
dcr a
jz ORR
;if(a>5) simply go to end of file
jmp OVER


ADD:
	lxi h, 8840H 
	mov e,m ;load 8 bits from addrress 8840 to register e
	inx h ; hl now stores 8841h
	mov c,m ;load 8 bits from addrress 8841 to register c
	mvi b, 00H 
	mvi d, 00H

	lxi h, 0000H ; initialise hl with 0000h
	dad b ; add bc to hl;
	dad d ; add de to hl;
	; any carry will be indicated in h register
	mov a, l
	sta 8900H ; store lower 8 bits in location 8900h
	mov a, h
	sta 8901H ; store carry if any in location 8901h
	jmp OVER

SUB:
	lxi h, 8840H 
	mov a,m ;load 8 bits from addrress 8840 to register a
	inx h ; hl now stores 8841h
	mov b,m ;load 8 bits from addrress 8841 to register b
	sub b ; sub b from a
	sta 8900H ; store result in 8900h
	jmp OVER

MUL:
	lxi h, 8840H
	mov e, m ;load 8 bits from addrress 8840 to register e
	inx h ; hl now stores 8841h
	mov b, m ;load 8 bits from addrress 8841 to register b
	mvi d, 00H 
	lxi h, 0000H ; hl stores answer and is initialised with 0

	;adding de b times to hl
	LOOP: ; repeates till b becomes 0.
		dad d ;hl+=de
		dcr b ;b--
		jnz LOOP 

	mov a, l
	sta 8900H ; store lower 8 bits in location 8900h
	mov a, h
	sta 8901H ; store higher 8 bits in location 8901h

	jmp OVER

DIV:
	lxi h, 8840H
	mov a, m ;load 8 bits from addrress 8840 to register a
	inx h ; hl now stores 8841h
	mov b, m ;load 8 bits from addrress 8841 to register b
	mvi c, 00H ; c stores quotient

	LOOP2:
		cmp b ; check if a>=b
		jc STR ; if a<b exit loop
		sub b ; else sub b
		inr c ; increment quotient
		jmp LOOP2

	STR:
		sta 8900H ; store remainder in location 8900h
		mov a,c
		sta 8901H ; store quotient in location 8901h

	jmp OVER


;additional feature to or two 8 bits number
ORR:
	lxi h, 8840H
	mov a, m ;load 8 bits from addrress 8840 to register a
	inx h ; hl now stores 8841h
	mov b, m ;load 8 bits from addrress 8841 to register b
	ora b ; a or b(bitwise)
	sta 8900H ;store result in 8900h
	jmp OVER


OVER:
	RST 5