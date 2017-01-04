[bits 16]
;Switch to protected mode
switch_to_pm:

	cli	;clear interrupts

	lgdt [gdt_descriptor] ;load global descriptor table
	
	mov eax,cr0	;set first bit of control register
	or eax,0x1
	mov cr0,eax
	

	jmp CODE_SEG:init_pm	;far jump to 32 bit code

[bits 32]
;initialize registers and stack in protected mode
init_pm:

	mov ax,DATA_SEG		;old segments meaningless
	mov ds, ax		;point seg registers to data selector
	mov ss, ax		;defined in GDT
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000	;update stack position
	mov esp, ebp	

	call BEGIN_PM

