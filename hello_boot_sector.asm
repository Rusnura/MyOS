; <ASM>
mov ah, 0x0e ; tty mode

mov al, 'H'
int 0x10

mov al, 'E'
int 0x10

mov al, 'L'
int 0x10
int 0x10 ; Prints 'l' symbol again

mov al, 'O'
int 0x10

mov al, ' '
int 0x10

jmp $ ; jump to current address

times 510 - ($-$$) db 0
dw 0xaa55
; </ASM>