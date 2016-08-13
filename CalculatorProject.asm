
;@Authors:    

;1)Khan,Tanimul haque (Addition,Subtraction)
;2)Basak,Shovon(Division)
;3)Faisal,Kazi(Multiplication,Power,Factorial, Percentage, Colour, Interface)           


;4)INDEC & OUTDEC (Acknowledgement)   


;-----------------------------------------------------------------------------------------------------
             ;--------------Acknowledgement--------------------            
;Assembly Language Programming and Organization of the IBM PC By Ytha Yu & Charles Marut.
;Copyright @1992 By McGraw-Hill,inc.All Rights Reserved.   

;http://stackoverflow.com/questions/13979246/x86-video-mode-clear-screen
;------------------------------------------------------------------------------------------------


.MODEL SMALL
.STACK 100h
.DATA
A DW ?
B DW ?
C DW 100D
SV DB ?  ;variable to check sign  Quotient
SVR DB ?  ;variable to check sign for remainder

;newLine
NL DB 0Ah,0Dh,'$'
BS DB 08H,' ',08H,'$'

;procs
SB DB 0Ah,0Dh,' Submitted By: $'
SEM DB 0Ah,0Dh,'                         ~~~SEMESTER: SPRING 2015-2016~~~ $'
COR DB 0Ah,0Dh,'                  COURSE: COMPUTER ORGANIZATION AND ARCHITECTURE $'
SEC DB   0Ah,0Dh,'                                    SECTION: E $'
SM DB 0Ah,0Dh,' Moderator: Mohammad Samawat Ullah',0Ah,0Dh,'            Assistant Professor',0Ah,0Dh, '            American International University-Bangladesh $'
ID1 DB 0Ah,0Dh,'ID: 15-28657-1 $'
ID2 DB 0Ah,0Dh,'ID: 15-28657-1 $'
ID3 DB 0Ah,0Dh,'ID: 15-28657-1 $'
SB1 DB 0Ah,0Dh,' 1.Tanimul,Haque Khan                  ID: 15-29119-1 $'
SB2 DB 0Ah,0Dh,' 2.Shovon Basak                        ID: 15-28970-1 $'

SB3 DB 0Ah,0Dh,' 3.Kazi Faisal                         ID: 15-28657-1 $'
I1 DB 0Ah,0Ah,0Dh,'Enter The 1st Number : $'
I2 DB 0Ah,0Dh,'Enter The 2nd Number: $'
I3 DB 0Ah,0Dh,'Enter The  Power(Positive Number Only): $'
O1 DB 0Ah,0AH,0Dh,'The Result is: 1$'
OZ DB 0Ah,0Dh,'INVALID!!!!!!! $'
OUTPUT DB 0Ah,0Ah,0Dh,'The Result is: $'
OF DB 0Ah,0Ah,0Dh,'OVERFLOW!!!!!!!',0ah,0dh,'$'
QUOTIENT DB 0Ah,0Ah,0Dh,'   Quotient: $'
R DB '   Remainder: $'
INSTRUCTION DB 0Dh,'You must enter a number in range -32767 to 32767' ,0AH,0Dh,'$'

;INTERFACE
pn DB '-_-_-_-_-_-_-_-_-_-_-_-_-ASSEMBLY - Calculator Project-_-_-_-_-_-_-_-_-_-_-_-_-',0Ah,0Dh,'$'  
op DB 0Ah,0Dh,'1)Addition(+)',0Ah,0Dh,'2)Subtraction(-)',0Ah,0Dh,'3)Multiplication(*)',0Ah,0Dh,'4)Division(/)',0Ah,0Dh,'5)Power(^)',0Ah,0Dh,'6)Factorial(!)',0Ah,0Dh,'7)Percentage(%)',0Ah,0Dh,'8)Clear screen',0Ah,0Dh,'9)Exit$' 
opa DB 0Ah,0Dh,'->Please Enter desired Operation: $'
 
.CODE

MAIN PROC
    
   MOV AX,@DATA
   MOV DS,AX
   
   
  
  ;print the project name
  MOV BL,78 ;color index
  MOV ah,9
  LEA DX,PN
  MOV AL,0
  INT 10H
  int 21h
  
  ;semester name
  MOV BL,13 ;color index
   MOV ah,9
  LEA DX,SEM
   MOV AL,0   ; avoid garbage
  INT 10H
  int 21h
  
  ;course name
  MOV BL,13 ;color index
   MOV ah,9
  LEA DX,COR
   MOV AL,0   ; avoid garbage
  INT 10H
  int 21h
  
  ;section name
  MOV BL,13 ;color index
   MOV ah,9
  LEA DX,SEC
   MOV AL,0   ; avoid garbage
  INT 10H
  int 21h
  
   MOV BL,14 ;color index
   MOV ah,9
  LEA DX,SB
   MOV AL,0   ; avoid garbage
  INT 10H
  int 21h
  
  MOV BL,11    ;color index
   MOV ah,9
  LEA DX,SB1
   MOV AL,0  ;avoid extra line
  INT 10H
  int 21h
  
    MOV BL,11  ;color index
   MOV ah,9
  LEA DX,SB2
   MOV AL,0    ;avoid extra line
  INT 10H
  int 21h
  
    MOV BL,11    ;color index
   MOV ah,9
  LEA DX,SB3
   MOV AL,0    ;avoid garbage
  INT 10H
  int 21h
  
   
   MOV BL,12      ;color index
   MOV ah,9
  LEA DX,SM 
  MOV AL,0        ;avoid extra line
  INT 10H
  INT 21H
  
        
        
        
  MOV ah,9
  LEA DX,NL
  int 21h
  
   
  

@START:
  
  
  MOV BL,7          ;color index
  MOV AH,9
  LEA DX,INSTRUCTION
  MOV AL,0            ;avoid garbage
  INT 10H
  INT 21H

@OPERATION:  
  ;Print Options
  MOV ah,9
  LEA DX,OP
  int 21h  
  
@OPERATIONAGAIN:
  
  MOV ah,9
  LEA DX,OPA
              ;avoid garbage
  
  int 21h
    
  

@Command:  
  ;take operation input 
  
  MOV AH,1
  int 21h
  
  CMP Al,'1'
  JE SUM
  CMP AL,'2'
  JE SUBSTRACT
  CMP AL,'3'
  JE MULL
  CMP AL,'4'
  JE DIVV
  CMP AL,'5'
  JE POW
  CMP AL,'6'
  JE FACT  
  CMP AL,'7'
  JE per
  CMP AL,'8'
  JE CLS
  CMP AL,'9'
  JE END
  
  MOV AH,9
  LEA DX,BS
  INT 21H
  JMP @Command
  


;func call tags   
SUM:
    call plus
    jmp @OPERATIONAGAIN   

SUBSTRACT:
    call minus
    jmp @OPERATIONAGAIN

MULL:    
    call multiplication
    jmp @OPERATIONAGAIN

    
DIVV:
    call DIVISION
    jmp  @OPERATIONAGAIN
    
POW:
    CALL POWER
    JMP @OPERATIONAGAIN

FACT:
    CALL FACTORIAL
    JMP @OPERATIONAGAIN 
    
per:
    CALL Percentage 
    JMP @OPERATIONAGAIN            
      
cls:    
;stack overflow------
      ;clear screen
      mov ax,0003h
      int 10h
      jmp  @START
;---------------------        
    
MAIN ENDP



;Written by Tanimul

;SUM FUNC--------------------------------------------------------------------------------------------------

PLUS proc
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
startsum:
     ;1st input proc
    mov AH,9
    lea dx,I1
    int 21h
    
    
    call INDEC
    MOV A,AX
    
    ;2nd input proc
    mov AH,9
    lea dx,I2
    int 21h
    
    
    
    call INDEC
    MOV B,AX
    
    ;NOW ADD Stuff
    
    MOV BX,A
    ADD BX,B
    JO @OVERFLOWADD
    
  
    ;print sum
    MOV AH,9
    LEA DX,OUTPUT
    int 21h
       
    ;call output
    MOV AX,BX
    
    CALL OUTDEC
     
    ;print newline
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl,0Dh
    int 21h
    
    POP DX
    POP CX
    POP BX
    POP AX
        
  
ret
@OVERFLOWADD:  
     ;print of
    mov ah,9
    LEA DX,OF
    int 21h
    jmp @OPERATIONAGAIN

    
PLUS endp                                                                                          


;SUB FUNC--------------------------------------------------------------------------------------------------

MINUS proc
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
startSUB:
     ;1st input proc
    mov AH,9
    lea dx,I1
    int 21h
    
    
    call INDEC
    MOV A,AX
    
    ;2nd input proc
    mov AH,9
    lea dx,I2
    int 21h
    
    
    
    call INDEC
    MOV B,AX
    
    ;NOW A-b
    
    MOV BX,A
    SUB BX,B
    JO @OVERFLOWsub
    
  
    ;print SUB
    MOV AH,9
    LEA DX,OUTPUT
    int 21h
       
    ;call output
    MOV AX,BX
    CALL OUTDEC
     
    ;print newline
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl,0Dh
    int 21h
    
    POP DX
    POP CX
    POP BX
    POP AX
        
  
ret
@OVERFLOWsub:  
     ;print of
    mov ah,9
    LEA DX,OF
    int 21h
    jmp @OPERATIONAGAIN
    
MINUS endp


;Written By Faisal;

;Multiplication Procedure;

MULTIPLICATION proc
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
startMUL:
     ;1st input proc
    mov AH,9
    lea dx,I1
    int 21h
    
    
    call INDEC
    MOV A,AX
    
    ;2nd input proc
    mov AH,9
    lea dx,I2
    int 21h
    
    
    
    call INDEC
    MOV B,AX
    
    ;MULL
    
    MOV AX,A
    IMUL B
    JO @OVERFLOWMUL
    PUSH AX
    
  
    ;print sum
    MOV AH,9
    LEA DX,OUTPUT
    int 21h
       
    ;call output
    POP AX
    CALL OUTDEC
    
        ;print newline
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl,0Dh
    int 21h
    
    POP DX
    POP CX
    POP BX
    POP AX
        
  
ret
@OVERFLOWMUL:  
     ;print of
     ;mov bl,12         ;change clr
    mov ah,9
    LEA DX,OF
    ;MOV AL,0            ;avoid garbage
    ;INT 10H
    int 21h
    ;mov bl,10           ;rechange clr
    ;MOV AL,0            ;avoid garbage
    ;INT 10H
    jmp @OPERATIONAGAIN
    
    MULTIPLICATION endp

;Written By Faisal;

;POWER Procedure;

POWER proc
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
startPOW:
     ;1st input proc
    mov AH,9
    lea dx,I1
    int 21h
    
    
    call INDEC
    MOV A,AX
    
    ;2nd input proc
    mov AH,9
    lea dx,I3
    int 21h 
    
    
    
    
    
    call INDEC
    cmp AX,0
    JL invalid
    MOV B,AX
    Sub B,1
    MOV CX,B
    

    ;MULL
     
    MOV AX,A
PO1:
    IMUL A
    JO @OVERFLOWPOW
    LOOP PO1
    PUSH AX
    
  
    ;print sum
    MOV AH,9
    LEA DX,OUTPUT
    int 21h
       
    ;call output
    POP AX
    CALL OUTDEC
    
        ;print newline
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl,0Dh
    int 21h
    
    POP DX
    POP CX
    POP BX
    POP AX
        
  
ret

invalid:
          mov bl,12         ;change clr
    mov ah,9
    LEA DX,Oz
    MOV AL,0            ;avoid garbage
    INT 10H
    int 21h
    mov bl,7           ;rechange clr
    MOV AL,0            ;avoid garbage
    INT 10H
    jmp startpow
    


@OVERFLOWPOW:  
     ;print of
     ;mov bl,12         ;change clr
    mov ah,9
    LEA DX,OF
    ;MOV AL,0            ;avoid garbage
    ;INT 10H
    int 21h
    ;mov bl,10           ;rechange clr
    ;MOV AL,0            ;avoid garbage
    ;INT 10H
    jmp @OPERATIONAGAIN
    
    POWER endp
    
 
 
;Written By Faisal 
 
 
 

FACTORIAL proc
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
startFACT:
     ;1st input proc
    mov AH,9
    lea dx,I1
    int 21h
    
    
    call INDEC
    MOV A,AX
    MOV AX,A
    CMP AX,0D
    JE KO
    JNS FO1
    JMP NP
    
    
KO: MOV AH,9
    LEA DX,O1
    int 21h
    
    MOV AH,9
    LEA DX,NL
    int 21h
    
    jmp @OPERATION
    
np: 
    mov bl,12 
    MOV AH,9
    LEA DX,Oz
    MOV AL,0            ;avoid garbage
    INT 10H
    int 21h
    mov bl,10
    mov al,0
    int 10h
     jmp startFACT    
    
    
    
    
FO1:
   DEC A
    IMUL A
     JO @OVERFLOWFACT
    MOV CX,A
    CMP CX,01
    JNZ FO1
   
    LOOP FO1
    PUSH AX
    
  
    ;print sum
    MOV AH,9
    LEA DX,OUTPUT
    int 21h
       
    ;call output
    POP AX
    CALL OUTDEC
    
        ;print newline
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl,0Dh
    int 21h
    
    POP DX
    POP CX
    POP BX
    POP AX
        
  
ret
@OVERFLOWFACT:  
     ;print of
     ;mov bl,12         ;change clr
    mov ah,9
    LEA DX,OF
    ;MOV AL,0            ;avoid garbage
    ;INT 10H
    int 21h
    ;mov bl,10           ;rechange clr
    ;MOV AL,0            ;avoid garbage
    ;INT 10H
    jmp @OPERATIONAGAIN
    
    FACTORIAL endp
   
 
 
 
;Written by Faisal

;Percentage FUNC--------------------------------------------------------------------------------------------------


Percentage proc
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
startper:    
    MOV SV,0  ;initializing sign variable as 0 
    MOV SVR,0 

    ;1st input proc
    mov AH,9
    lea dx,I1
    int 21h
    
    
    call INDEC
    MOV A,AX
    
    JNS nxt ;check if negetive number
    NEG A    ;if negative
    MOV SV,1  
    MOV SVR,1
    
    
nxt:
    ;2nd input proc
    mov AH,9
    lea dx,I2
    int 21h
    
    
    
    call INDEC
    MOV B,AX
    JNS perc ;check if negetive number
    NEG B     ;if negative
    XOR SV,1  ;check if sign for 2 numbers are same 
    OR SVR,1    
    
 

perc:    
      XOR DX,DX ;clear dx register to ignore div overflow
    MOV AX,A
    IMUL B
    
    xor dx,dx
    ;MOV AX,B
    DIV C  
    PUSH DX
    PUSH AX
    
    
    ;print quotient
    MOV AH,9
    LEA DX,output
    int 21h
    
    CMP SV,0
    JZ OUTPUTper
    
    ;setting minus for output
    POP AX
    NEG AX 
    PUSH AX 

OUTPUTper:       
    ;call output
    POP AX
    CALL OUTDEC
     
    
    
    ;print Remainder
    mov ah,2
    mov dl,'.'
    int 21h
          
    CMP SVR,0
    JZ REMAINDERper      
    
    ;setting minus for output
    POP AX
    NEG AX
    PUSH AX 

REMAINDERper:    
    POP AX
    CALL OUTDEC
    
    ;print newline
    mov ah,9
    LEA DX,NL
    int 21h
    
    POP DX
    POP CX
    POP BX
    POP AX
        
        
  
ret



    
Percentage endp 
 
 
 
 
 
 

;Written by Shovon

;DIVISION FUNC--------------------------------------------------------------------------------------------------


DIVISION proc
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
startdiv:    
    MOV SV,0  ;initializing sign variable as 0 
    MOV SVR,0 

    ;1st input proc
    mov AH,9
    lea dx,I1
    int 21h
    
    
    call INDEC
    MOV A,AX
    
    JNS next ;check if negetive number
    NEG A    ;if negative
    MOV SV,1  
    MOV SVR,1
    
next:    
    ;2nd input proc
    mov AH,9
    lea dx,I2
    int 21h
    
    
    
    call INDEC
    MOV B,AX
    JNS DIVVV ;check if negetive number
    NEG B     ;if negative
    XOR SV,1  ;check if sign for 2 numbers are same 
    OR SVR,1
 

DIVVV:    
    XOR DX,DX ;clear dx register to ignore div overflow
    MOV AX,A
    DIV B  
    
    PUSH DX
    PUSH AX
    
    ;print quotient
    MOV AH,9
    LEA DX,QUOTIENT
    int 21h
    
    CMP SV,0
    JZ OUTPUTDIV
    
    ;setting minus for output
    POP AX
    NEG AX 
    PUSH AX  

OUTPUTDIV:       
    ;call output
    POP AX
    CALL OUTDEC
     
    ;print newline
    mov ah,9
    LEA DX,NL
    int 21h 
    
    ;print Remainder
    mov ah,9
    LEA DX,R
    int 21h
          
    CMP SVR,0
    JZ REMAINDER      
    
    ;setting minus for output
    POP AX
    NEG AX
    PUSH AX 

REMAINDER:    
    POP AX
    CALL OUTDEC
    
    ;print newline
    mov ah,9
    LEA DX,NL
    int 21h
    
    POP DX
    POP CX
    POP BX
    POP AX
        
  
ret

    
DIVISION endp










;------------------------------------------------------------------------------------------------------
;Input decimal


INDEC PROC 
    ;reads a number between -32768 to 32767
    ;input: none
    ;output:AX = binary equivalent of number
    PUSH Bx
    PUSH Cx
    PUSH Dx
@BEGIN:

;total=0
    XOR Bx,Bx ;Bx holds total        
;negative = false 
    XOR Cx,Cx ;Cx holds sign
;read a character
    MOV Ah,1
    int 21h ;char in AL
;Case char of
    CMP AL,'-'
    JE @MINUS
    CMP AL,'+'
    JE @PLUS
    JMP @REPEAT2 ;start processing characters
@MINUS:
    mov Cx,1 ;neg=true
@PLUS:
    int 21h ;read a char
;end case
@REPEAT2:
;if character is between 0 and 9
    cmp al,'0' ;char >=0 ?
    JNGE @NOT_DIGIT;illigal character
    CMP AL,'9' ;char <=9 ?
    JNLE @NOT_DIGIT;illigal character
;then convert char to a digit                
    AND Ax,000Fh ;converts to digit
    PUSH Ax ;save on stack
;total = total x 10 + digit
    MOV Ax,10 ;get 10
    MUL BX ;Total=total x10 
   
    
    POP BX ;retrive digit
    ADD AX,Bx ; total= total x10 + digit
    JS @OVERFLOW ;if sign bit is true then overflow
    OR DX,DX       ;check if dx is 0 or not
    JNZ @OVERFLOW  ;if dx > 0 then overflow
    MOV BX,Ax

@RC:    
;read a character 
    MOV Ah,1
    int 21h
    CMP AL,08h
    JE @BS    ;if backspace pressed then delete last digit
    
    
    CMP AL,0Dh ; carriage return?
    JNE @REPEAT2 ;no,keep going
;untill CR
    mov Ax,Bx ;Store number in Ax
;if Negative 
    OR Cx,Cx ;negative number        
    JE @EXIT ;no exit
;then
    NEG AX ;yes negate
;end if
@EXIT:
    POP DX
    POP CX
    POP BX
    ret  ;return's with Input in Ax

;here if illigal character entered
@NOT_DIGIT:
    MOV AH,9
    LEA DX,BS
    INT 21H
    
    XOR DX,DX
    JMP @RC ;go to begining    

@BS: ;if backspace pressed  
    MOV AX,BX
    MOV BX,10
    DIV BX
    
    PUSH AX
    MOV AH,2
    MOV DL,20H
    INT 21H
    MOV DL,08H
    INT 21H
    
    XOR DX,DX
    POP BX
    
    JMP @RC

    
@OVERFLOW: ;if overflow
    SUB Ax,Bx
    MOV BX,10
    DIV BX
    
    PUSH Ax

    MOV AH,9
    LEA DX,BS
    INT 21H
      
    XOR DX,DX
    POP Bx
    
    JMP @RC ;go to begining 
    
ENDP INDEC  


;----------------------------------------------------------------------------------------------------




;----------------------------------------------------------------------------------------------------
;output decimal

OUTDEC PROC

;prints AX as a signed decimal integer
;INPUT : AX
;Output : NONE

       ;save registers
       PUSH AX
       PUSH BX
       PUSH CX
       PUSH DX
;if AX <=0

        OR AX,AX    ;AX<0 ?
        JGE @END_if1  ;no >0      
;Then   
    ;so the value is negative 
        PUSH AX
        MOV DL,'-'
        MOV AH,2
        INT 21h
        POP AX
        NEG AX ;make positive to print
@END_IF1:
;get decimal  digits
        XOR CX,CX ;CX counts digits
        MOV BX,10D ;BX has divisor
@REPEAT:
        XOR DX,DX
        DIV BX
        PUSH DX ;save remainder on stack
        INC CX                

;UNTILL 
        OR AX,AX ;Quotient =0?
        JNE @REPEAT ;keep going
;CONVERT DIGITS to character and print
        MOV AH,2
;for count times DO
@PRINT_LOOP:
        POP DX ;digit in DL
        OR DL,30h ; convert to char
        int 21h
        LOOP @PRINT_LOOP                
;END_FOR        


        POP DX
        POP CX
        POP BX
        POP AX
        Ret    

OUTDEC ENDP
   



END:
    MOV AH,4Ch
    int 21h
  