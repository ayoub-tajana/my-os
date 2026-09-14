# This program has been made by The Mountain Systems 2026 Copyright
.global _start
.section .text
.code16

_start:
    mov %dl, boot_drive
    #Set video mode
    mov $0x0, %ah
    mov $0x3, %al
    int $0x10
    
    
    mov $welcomemessage, %si
    mov $39,%cx


printwelcome:
    push %cx
    # 2 second delay
        mov $0x86, %ah
        mov $0x00, %al
        mov $0x0001, %cx
        mov $0x86A0, %dx
        int $0x15

    pop %cx
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
     push %cx
    # 2 second delay
        mov $0x86, %ah
        mov $0x00, %al
        mov $0x0001, %cx
        mov $0x86A0, %dx
        int $0x15
     pop %cx
    # enabling output to the screen (BIOS Function)
        mov $0x0E,%ah

    # Copy the character at the adress stored in REG %SI
        mov (%si), %al
        int $0x10 # BIOS Interrupt

        inc %si
        loop printloading_kernel

        jmp loadkernel

loadkernel:
    # Set segment first, before touching AH/AL
    mov $0x07E0,%ax
    mov %ax,%es
    mov $0x0000,%bx

    mov $0x02,%ah   # now safe: AH/AL set last
    mov $0x01,%al
    mov $0x00,%ch
    mov $0x02,%cl
    mov $0x00,%dh
    mov boot_drive,%dl

    int $0x13
    jc disk_error

    ljmp $0x07E0,$0x0000
disk_error:
    mov $diskerrmsg, %si
    mov $11, %cx
printerr:
    mov $0x0E, %ah
    mov (%si), %al
    int $0x10
    inc %si
    loop printerr
    jmp .

diskerrmsg:
    .ascii "Disk Error!"
welcomemessage:
    .ascii "The Mountain Systems Bootloader v1.0 \n\r"
loadingmsg:
    .ascii "Loading Kernel..."
boot_drive:
    .byte 0

fill:
      .fill 510 - (. - _start), 1, 0
    .word 0xAA55
