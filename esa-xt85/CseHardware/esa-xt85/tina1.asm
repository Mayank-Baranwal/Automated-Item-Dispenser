
      CPU "8085.TBL"
      HOF "INT8"

      ORG 8200H
      LXI   SP,0FFFFH
      MVI   A,82H
      OUT   43H
      MVI   D,12H
      XRA   A

      STA   H
N3:
      CALL  HELLO

      LDA   0A000H
      ANI   0FH

      JNZ   N1
N2:
      DCR   D
      JZ    N1
      CALL  HELLO
      CALL  DELAY2
      LXI   H,0A000H
      MOV   A,M
      LXI   H,0A001H
      MOV   M,A
      LXI   H,0A000H
      MVI   M,0AH
      CALL  HELLO
      CALL  DELAY2
      LXI   H,0A001H
      MOV   A,M
      LXI   H,0A000H
      MOV   M,A
      JMP   N2

N1:
      MVI   D,03H
      LXI   H,0A000H
      MOV   A,M
      INR   A
      DAA
      MOV   M,A
      CALL  DELAY1
      JMP   N3

      ORG   8250H

 DELAY1:
      PUSH PSW
      PUSH B
      PUSH D
      PUSH H

      LXI   B,0FFFFH
 DLY:
      DCX   B
      MOV   A,B
      ORA   C
      JNZ   DLY

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
      LDA   0A000H
      MVI   B,02H
      ANI   0FH
      JMP   NEXT
      ANI   0F0H
      RRC
      RRC
      RRC
      RRC
NEXT:
      LXI   H,9000H
      CPI   00H
      JZ    8500H

      INR   L
      CPI   01H
      JZ    8500H

      INR   L
      CPI   02H
      JZ    8500H

      INR   L
      CPI   03H
      JZ    8500H

      INR   L
      CPI   04H
      JZ    8500H

      INR   L
      CPI   05H
      JZ    8500H

      INR   L
      CPI   06H
      JZ    8500H

      INR   L
      CPI   07H
      JZ    8500H

      INR   L
      CPI   08H
      JZ    8500H

      INR   L
      CPI   09H
      JZ    8500H

      INR   L     ;  TESTING
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
      JNZ   800AH
      ;POP  H
      ;POP  D
      ;POP  B
      ;POP  PSW
      RET
