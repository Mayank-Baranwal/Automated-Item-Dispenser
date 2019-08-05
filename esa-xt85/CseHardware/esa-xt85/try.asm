

CPU   "8085.TBL"
HOF   "INT8"
ORG   9000H

      MVI   A,82H
      OUT   43H
      MVI   A,66H
;      MVI   H,02H
; LOOP9:
      MVI   C,02H
      MOV   B,A
      LOOP10:
            MVI   D,08H
            ANI   0FH
            CPI   00H
            JNZ   LOOP11
            MVI   A,0C0H
     LOOP11:
            CPI   01H
            JNZ   LOOP21
            MVI   A,0F9H
     LOOP21:
            CPI   02H
            JNZ   LOOP22
            MVI   A,0A4H
     LOOP22:
            CPI   03H
            JNZ   LOOP23
            MVI   A,0B0H
     LOOP23:
            CPI   04H
            JNZ   LOOP24
            MVI   A,99H
     LOOP24:
            CPI   05H
            JNZ   LOOP25
            MVI   A,92H
     LOOP25:
            CPI   06H
            JNZ   LOOP26
            MVI   A,82H
     LOOP26:
            CPI   07H
            JNZ   LOOP27
            MVI   A,0F8H
     LOOP27:
            CPI   08H
            JNZ   LOOP28
            MVI   A,80H
     LOOP28:
            CPI   09H
            JNZ   LOOP12
            MVI   A,98H

     LOOP12:
            STC
            CMC
            RAL
            MOV   E,A
            JC    LOOP13
            MVI   A,00H
            OUT   40H
            MVI   A,01H
            OUT   40H
            JMP   LOOP14
     LOOP13:
            MVI   A,02H
            OUT   40H
            MVI   A,03H
            OUT   40H
     LOOP14:
            DCR   D
            MOV   A,E
            JNZ   LOOP12
            MOV   A,B
            ANI   0F0H
            STA   9201H
            STC
            CMC
            RAL
            RAL
            RAL
            RAL
            RAL
            DCR   C
            JNZ   LOOP10
 ;           DCR   H
 ;           CALL  DELAY
 ;           CALL  DELAY
 ;           MVI   A,92H
 ;           JNZ   LOOP9
      POP   H
      POP   D
      POP   B
      POP   PSW
            RST   5



DELAY:
      PUSH  PSW
      PUSH  B
      PUSH  D
      PUSH  H

      MVI     C,0FFH
      LOOP2:
            MVI     D,0FFH
      LOOP1:
            DCR     D
            JNZ     LOOP1
            DCR     C
      JNZ     LOOP2
      MVI     C,0FFH
      LOOP4:
            MVI     D,0FFH
      LOOP3:
            DCR     D
            JNZ     LOOP3
            DCR     C
      JNZ     LOOP4
      MVI     C,0FFH
      LOOP6:
            MVI     D,0FFH
      LOOP5:
            DCR     D
            JNZ     LOOP5
            DCR     C
      JNZ     LOOP6

      POP   H
      POP   D
      POP   B
      POP   PSW
RET


DISPLAY:
      PUSH  PSW
      PUSH  B
      PUSH  D
      PUSH  H

      MOV   A,B
      STA   8FF1H
      CALL  044CH
      POP   H
      POP   D
      POP   B
      POP   PSW
RET
