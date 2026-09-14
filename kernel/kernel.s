# This program has been made by The Mountain Systems 2026 Copyright
.global _start
.section .text
.code16

_start:
    #Set video mode
    mov $0x0, %ah
    mov $0x3, %al
    int $0x10
    
    
    mov $message, %si
    mov $13,%cx


printtext:
    # print A
    mov $0x0E, %ah
    mov (%si), %al
    int $0x10

    inc %si
    loop printtext
    jmp .
message:
    .ascii "Kernel Loaded!"
    
    .fill 510 - (. - _start), 1, 0
    .word 0xAA55
