; === Prepare on Ubuntu ===
; sudo apt install qemu qemu-system-x86 nasm
;
; === Intro ===
; When computer starts the BIOS, it doesn't know how to load OS.
; It delegates task to the boot sector.
; 
; Boot sector need placed to standarted location:
; 1st sector of disk (cylinder=0, head=0, sector=0) and it takes 512 bytes.
;
; To make sure that the "disk is bootable" bios checks that bytes 511 and 512 of the alleged boot sector are bytes 0xAA55.
;          SIMPLE EXAMPLE OF BOOT SECTOR          ;
; e9 fd ff 00 00 00 00 00 00 00 00 00 00 00 00 00 ; (First 3 bytes are perform an infinitie jump)
; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ;
; [   .. lines with sixteen zero-bytes each ..  ] ;
; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa ; (Ends with 0xAA55. x86 is little-endian).
;

; <ASM CODE>
; main infinitie loop (e9 fd ff)
loop:
    jmp loop

; Fill of (510-size of previous code) with zeros
times 510-($-$$) db 0

; Add magic 0xAA55 number
dw 0xaa55
; </ASM CODE>

; For compile the code:
; nasm -f bin boot_sector.asm -o boot_sector.bin

; For start write:
; qemu-system-x86_64 boot_sector.bin --curses

; You will see a window open which says "Booting from Hard Disk..." and nothing else.
; It's normal because you just wrote an enfinite loop :D