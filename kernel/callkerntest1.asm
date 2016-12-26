;Credits to arjunsreedharan.org
;;callkerntest1.asm
bits 32 ;32 bit directive
section .text

global start
extern kmain	;Kernel main from C file

start:
	cli	;block interrupt
	mov esp, stack_space	;set stack pointer
	call kmain
	hlt	;halt CPU

section .bss
	resb	8192	;alloc 8KB for stack
	stack_space:
