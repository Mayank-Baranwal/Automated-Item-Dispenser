cpu "8085.tbl"
hof "int8"

org 9000h 

MVI A, 8BH
OUT 43H
SEN:
	IN 41H
	CMA
	OUT 40H

RST 5
