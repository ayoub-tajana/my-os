# This program has been made by The Mountain Systems 2026 Copyright
.global _start
.section .text
.code16

_start:
    #Set video mode
    mov $0x0, %ah
    mov $0x3, %al
    int $0x10
    
    
    mov $welcomemessage, %si
    mov $39,%cx


printwelcome:
    # 2 second delay
        mov $0x86, %ah
        mov $0x00, %al
        mov $0x0007, %cx
        mov $0xA120, %dx
        int $0x15

    # print text to screen
        mov $0x0E, %ah
        mov (%si), %al
        int $0x10

        inc %si
        loop printwelcome
    
        mov $loadingmsg, %si
        mov $17,%cx
        jmp printloading_kernel

printloading_kernel:
    
    # 2 second delay
        mov $0x86, %ah
        mov $0x00, %al
        mov $0x0007, %cx
        mov $0xA120, %dx
        int $0x15
    
    # enabling output to the screen (BIOS Function)
        mov $0x0E,%ah

    # Copy the character at the adress stored in REG %SI
        mov (%si), %al
        int $0x10 # BIOS Interrupt

        inc %si
        loop printloading_kernel

        jmp .
welcomemessage:
    .ascii "The Mountain Systems Bootloader v1.0 \n\r"
loadingmsg:
    .ascii "Loading Kernel..."
    .fill 510 - (. - _start), 1, 0
    .word 0xAA55
