;Encryption Program               (Encrypt.asm)

; This program demonstrates simple symmetric
; encryption using the XOR instruction.

INCLUDE Irvine32.inc
BUFMAX = 20        ; maximum buffer size

.data
xPrompt     BYTE    "X = ",0
yPrompt     BYTE    "Y = ",0
answer      BYTE    "GCD = ",0
againPrompt BYTE    "Do you wanna play again?(Y/n)",0
sX          DWORD    BUFMAX+1 DUP(0)
sY          DWORD    BUFMAX+1 DUP(0)
GCD         DWORD    ?

.code
main PROC
BG::
    call    InputTheString      ; input the plain text
    call    getGCD
    call    printAnswer
    call    Again
    exit
main ENDP


printAnswer     PROC
    pushad
    mov edx, OFFSET answer
    call WriteString
    mov eax, GCD
    call WriteInt
    call Crlf

    popad
    ret
printAnswer     ENDP

;-------------------------------------------------------
Again          PROC
;
; ask user if he wanna play again
;
;-------------------------------------------------------
    pushad
    mov edx, OFFSET againPrompt
    call WriteString
    call ReadChar
    call Crlf
    cmp al, 'Y'
    je  BG
    cmp al, 'y'
    je  BG
    popad
    ret
Again          ENDP



;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
    pushad
    mov edx,OFFSET xPrompt      ; X = 
    call    WriteString
    call    ReadInt
    mov     sX, eax

    mov edx, OFFSET yPrompt     ; Y =
    call    WriteString
    call    ReadInt
    mov     sY, eax

    call    Crlf
    popad
    ret
InputTheString ENDP

getGCD      PROC
    pushad
    mov eax, sX
    mov ecx, sY
D:
    mov edx, 0
    div ecx
    cmp edx, 0                  ; find GCD
    je  E
    mov eax, ecx
    mov ecx, edx
    jmp D

E:
    mov GCD, ecx
    popad
    ret
getGCD      ENDP



END main