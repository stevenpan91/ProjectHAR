all: os-image

run: all
	bochs -q

os-image: bootsec32.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel_entry.o kernel.o
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel.o: kernel.c
	gcc -ffreestanding -c $< -o $@

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf64 -o $@

bootsec32.bin: bootsec32.asm
	nasm $< -f bin -o $@


kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
