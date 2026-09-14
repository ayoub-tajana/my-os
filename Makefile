bootv1.0:
	as --32 ./boot/version1.0/bootloader.s -o ./boot/version1.0/object_files/bootloader.o
	ld -m elf_i386 -Ttext 0x7C00 --oformat binary ./boot/version1.0/object_files/bootloader.o -o ./boot/version1.0/executables/bootloader.bin
	qemu-system-x86_64 -drive format=raw,file=./boot/version1.0/executables/bootloader.bin

bootv1.1:
	as --32 ./boot/version1.1/bootloader.s -o ./boot/version1.1/object_files/bootloader.o
	ld -m elf_i386 -Ttext 0x7C00 --oformat binary ./boot/version1.1/object_files/bootloader.o -o ./boot/version1.1/executables/bootloader.bin
	qemu-system-x86_64 -drive format=raw,file=./boot/version1.1/executables/bootloader.bin

kernel:
	echo "Compiling BOOTLOADER..."
		as --32 ./boot/version2.0/bootloader.s -o ./boot/version2.0/object_files/bootloader.o
		ld -m elf_i386 -Ttext 0x7C00 --oformat binary ./boot/version2.0/object_files/bootloader.o -o ./boot/version2.0/executables/bootloader.bin
	echo "Compiling KERNEL..."
		as --32 ./kernel/kernel.s -o ./kernel/kernel.o
		ld -m elf_i386 -Ttext 0x07E00 --oformat binary ./kernel/kernel.o -o ./kernel/kernel.bin
	echo "Merging BOOTLOADER and KERNEL..."
		cat ./boot/version2.0/executables/bootloader.bin ./kernel/kernel.bin > ./os-img/os-img.bin
	echo "Start QEMU..."		
		qemu-system-x86_64 -drive format=raw,file=./os-img/os-img.bin

kernel-test:
	echo "Compiling BOOTLOADER..."
		as --32 ./boot/version2.0/bootloader.s -o ./boot/version2.0/object_files/bootloader.o
		ld -m elf_i386 -Ttext 0x7C00 --oformat binary ./boot/version2.0/object_files/bootloader.o -o ./boot/version2.0/executables/bootloader.bin
	echo "Compiling KERNEL..."
		as --32 ./kernel/kernel.s -o ./kernel/kernel.o
		ld -m elf_i386 -Ttext 0x07E0 --oformat binary ./kernel/kernel.o -o ./kernel/kernel.bin
	echo "Merging BOOTLOADER and KERNEL..."
		cat ./boot/version2.0/executables/bootloader.bin ./kernel/kernel.bin > ./os-img/os-img.bin
	echo "Start QEMU..."		
		qemu-system-x86_64 -S -s -drive format=raw,file=./os-img/os-img.bin