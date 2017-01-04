C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = $(C_SOURCES:.c=.o)

all: os-image
	mv os-image os-image.backup

run: all
	bochs -q

os-image: boot/bootsec32.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

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
