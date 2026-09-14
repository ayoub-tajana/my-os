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
    mov $36,%cx


printwelcome:
    # print A
    mov $0x0E, %ah
    mov (%si), %al
    int $0x10

    inc %si
    loop printwelcome
    
    mov $loadingmsg, %si
    mov $17,%cx
    jmp printloading_kernel

printloading_kernel:
    mov $0x0E,%ah
    mov (%si), %al
    int $0x10

    inc %si
    loop printloading_kernel

    jmp .
welcomemessage:
    .ascii "The Mountain Systems Bootloader v1.0"
loadingmsg:
    .ascii "Loading Kernel..."
