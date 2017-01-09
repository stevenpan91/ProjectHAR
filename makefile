C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = $(C_SOURCES:.c=.o)

all: os-image

run: all
	bochs -q

os-image: bootsector/bootsec32.bin kernel/kernel.bin
	if [ -f os-image ]; then mv os-image os-image.backup; fi;
	cat $^ > os-image

bootsector/bootsec32.bin: bootsector/bootsec32.asm
	nasm $< -f bin -o $@

kernel/kernel.bin: kernel/kernel_entry.o ${OBJ}
#kernel.bin: kernel/kernel_entry.o kernel/kernel.o
	ld -o $@ -Ttext 0x1000 $^ --oformat binary --entry main

#generic rule for compiling C to an object file
%.o: %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

#assemble kernel entry
%.o: %.asm
	nasm $< -f elf64 -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

#generic disassemble
%.dis : %.bin
	ndisasm -b 32 $< > $@
