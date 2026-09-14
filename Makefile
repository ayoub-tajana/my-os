boot:
	as --32 ./boot/bootloader.s -o ./boot/bootloader.o
	ld -m elf_i386 -Ttext 0x7C00 --oformat binary ./boot/bootloader.o -o ./boot/bootloader.bin
	qemu-system-x86_64 -drive format=raw,file=./boot/bootloader.bin