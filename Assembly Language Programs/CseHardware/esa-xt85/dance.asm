CPU "8085.TBL"
HOF "INT8"

ORG 09000H

MVI     A,82H
OUT     43H
LOOP:
MVI     A,80H
OUT     40H
CALL    DELAY
MVI     A,40H
OUT     40h
CALL    DELAY
MVI     A,20H
OUT     40h
CALL    DELAY
MVI     A,10H
OUT     40h
CALL    DELAY
MVI     A,08H
OUT     40h
CALL    DELAY
MVI     A,04H
OUT     40h
CALL    DELAY
MVI     A,02H
OUT     40h
CALL    DELAY
MVI     A,01H
OUT     40h
CALL    DELAY
JMP     LOOP

DELAY:
MVI     C,0FFH
LOOP2:
MVI     D,0FFH
LOOP1:
DCR     D
JNZ     LOOP1
DCR     C
JNZ     LOOP2
RET



HLT