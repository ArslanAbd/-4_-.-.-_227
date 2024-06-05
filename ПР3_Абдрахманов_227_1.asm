; multi-segment executable file template.

data segment
    ; add your data here!
    A DB ? 
X DB ? 
Y DB ? 
PERENOS DB 13,10,"$" 
VVOD_A DB 13,10,"VVEDITE A=$" 
VVOD_X DB 13,10,"VVEDITE X=$",13,10 
VIVOD_Y DB "Y=$" 
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends                                      

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    XOR AX, AX 
    MOV DX, OFFSET VVOD_A 
    MOV AH, 9 
    INT 21H 
SLED2:
    MOV AH, 1 
    INT 21H 
    CMP AL, "-" 
    JNZ SLED1 
    MOV BX, 1 
    JMP SLED2 
SLED1:
    SUB AL, 30H 
    TEST BX, BX 
    JZ SLED3 
    NEG AL

SLED3:
    MOV A, AL 
    XOR AX, AX 
    XOR BX, BX 
    MOV DX, OFFSET VVOD_X 
    MOV AH, 9 
    INT 21H 
SLED4:
    MOV AH, 1 
    INT 21H 
    CMP AL, "-" 
    JNZ SLED5 
    MOV BX, 1 
    JMP SLED4 
SLED5:
    SUB AL, 30H 
    TEST BX, BX 
    JZ SLED6 
    NEG AL 
SLED6:
    MOV X, AL 
    MOV AL, A 
    CMP AL, X 
    JL @LEFT 
    SUB AL, X 
    JMP SHORT @VIXOD 
@LEFT:
   ADD AL, X 
@VIXOD:
   MOV Y, AL 
   MOV DX, OFFSET PERENOS 
   MOV AH, 9 
   INT 21H 
   MOV DX, OFFSET VIVOD_Y 
   MOV AH, 9 
   INT 21H 
   MOV AL, Y 
   CMP Y, 0 
   JGE SLED7 
   NEG AL 
   MOV BL, AL 
   MOV DL, "-" 
   MOV AH, 2 
   INT 21H 
   MOV DL, BL 
   ADD DL, 30H 
   INT 21H 
   JMP SLED8 
SLED7:
   MOV DL, Y 
   ADD DL, 30H 
   MOV AH, 2 
   INT 21H 
SLED8:
   MOV DX, OFFSET PERENOS 
   MOV AH, 9 
   INT 21H 

   MOV AH, 1 
   INT 21H 
   MOV AX, 4C00H 
   INT 21H        
    
    
    
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
