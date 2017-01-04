[org 0x7c00]


	mov bp, 0x9000	;set stack
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_test
	
	call switch_to_pm	;never returned from here

	jmp $

%include "print_str.asm"
%include "print_str32.asm"
%include "gdt.asm"
%include "switchpm.asm"


[bits 32]

;arrive here after switching to and initialising protected mode
BEGIN_PM:
	
	mov ebx, MSG_PROT_MODE
	call print_string_pm

	jmp $

;Global var
MSG_REAL_MODE 	db	"Started in 16-bit Real Mode", 0
MSG_PROT_MODE 	db	"Successfully landed in 32-bit Protected Mode",0

;Bootsec padding
times 510-($-$$) db 0
dw 0xaa55
