bootv1.0:
	as --32 ./boot/version1.0/bootloader.s -o ./boot/version1.0/object_files/bootloader.o
	ld -m elf_i386 -Ttext 0x7C00 --oformat binary ./boot/version1.0/object_files/bootloader.o -o ./boot/version1.0/executables/bootloader.bin
	qemu-system-x86_64 -drive format=raw,file=./boot/version1.0/executables/bootloader.bin

bootv1.1:
	as --32 ./boot/version1.1/bootloader.s -o ./boot/version1.1/object_files/bootloader.o
	ld -m elf_i386 -Ttext 0x7C00 --oformat binary ./boot/version1.1/object_files/bootloader.o -o ./boot/version1.1/executables/bootloader.bin
	qemu-system-x86_64 -drive format=raw,file=./boot/version1.1/executables/bootloader.bin

bootv2:
	as --32 ./boot/version2.0/bootloader.s -o ./boot/version2.0/object_files/bootloader.o
	ld -m elf_i386 -Ttext 0x7C00 --oformat binary ./boot/version2.0/object_files/bootloader.o -o ./boot/version2.0/executables/bootloader.bin
	qemu-system-x86_64 -drive format=raw,file=./boot/version2.0/executables/bootloader.bin