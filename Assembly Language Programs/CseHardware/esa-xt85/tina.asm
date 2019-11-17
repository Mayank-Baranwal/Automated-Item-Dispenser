      CPU "8085.TBL"
      HOF "INT8"

      ORG   8200H
      LXI   SP,0FFFFH
      MVI   A,82H
      OUT   43H
      MVI   D,12

      LXI   H,0A000h
      MVI   A,01h
      ;STA   0A000h
      MOV   M,A
N3:

      CALL  HELLO

      LDA   0A000H
      ANI   00FH
      CPI   00h
      JNZ   N1
N2:
      CALL  HELLO
      CALL  DELAY2
      LXI   H,0A000H
      MOV   A,M
      LXI   H,0A001H
      MOV   M,A
      ANI   0Fh
      ORI   0A0h
      LXI   H,0A000H
      MOV   M,A
      CALL  HELLO
      CALL  DELAY1
      LXI   H,0A001H
      MOV   A,M
      ;ANI   0Fh
      ;ORI   0A0h
      LXI   H,0A000H
      MOV   M,A
      CALL  HELLO
      CALL  DELAY1
      LXI   H,0A001H
      MOV   A,M
      ANI   0Fh
      ORI   0A0h
      LXI   H,0A000H
      MOV   M,A
      CALL  HELLO
      CALL  DELAY1
      LXI   H,0A001H
      MOV   A,M
      LXI   H,0A000H
      ;DCR   A
      MOV   M,A


N1:
      MVI   D,03H
      LXI   H,0A000H
      MOV   A,M
      INR   A
      DAA
      MOV   M,A

   
      CALL DELAY1
      

      JMP   N3

      ;ORG   8250H
 DELAY1:
      PUSH PSW
      PUSH B
      PUSH D
      PUSH H

      MVI   B,0FFH
 DLY1:
      CALL DELAY12
      NOP
      DCR   B
      JNZ   DLY1

      POP  H
      POP  D
      POP  B
      POP  PSW
      RET






 DELAY12:
      PUSH PSW
      PUSH B
      PUSH D
      PUSH H

      MVI   B,0FFH
 DLY12:
      DCR   B
      NOP
      JNZ   DLY12

      POP  H
      POP  D
      POP  B
      POP  PSW
      RET
 DELAY2:
      LXI   B,2FFFH
 DLY2:
      DCX   B
      MOV   A,B
      ORA   C
      JNZ   DLY2

      RET





      ORG   8000H
      
HELLO:
      PUSH PSW
      PUSH B
      PUSH D
      PUSH H

      LDA   0A000H
      MVI   B,02H
      ANI   0FH
      JMP   NEXT

LA:   ANI   0F0H

      RRC
      RRC
      RRC
      RRC
NEXT:
      LXI   H,9000H
      CPI   00H
      JZ    8500H

      INX   H
      CPI   01H
      JZ    8500H

      INX H
      CPI   02H
      JZ    8500H

      INX H     
      CPI   03H
      JZ    8500H

      INX H      ;INR   L
      CPI   04H
      JZ    8500H

      INX H      ;INR   L
      CPI   05H
      JZ    8500H

      INX H     ; INR   L
      CPI   06H
      JZ    8500H

      INX H     ; INR   L
      CPI   07H
      JZ    8500H

      INX H     ; INR   L
      CPI   08H
      JZ    8500H

      INX H     ; INR   L
      CPI   09H
      JZ    8500H

      INX H     ; INR   L     ;  TESTING
      JMP   8500H ;

      ORG   8500H

      MOV   A,M
      MVI   C,08H
 LOC3:
      ANI   01H
      JZ    LOC1
      MVI   A,01H
      OUT   40H
      MVI   A,03H
      OUT   40H
      JMP   LOC2
 LOC1:
      MVI   A,00H
      OUT   40H
      MVI   A,02H
      OUT   40H
 LOC2:
      MOV   A,M
      RRC
      MOV   M,A

      DCR   C
      JNZ    LOC3
      LDA   0A000H
      DCR   B
      JNZ   LA
      POP  H
      POP  D
      POP  B
      POP  PSW
      RET
