[org 0x7c00]
KERNEL_OFFSET equ 0x1000
	;call clearsn
	mov [BOOT_DRIVE], dl ;BIOS stores boot drive in DL

	mov bp, 0x9000	;set stack
	mov sp, bp
	
	call print_newln
	mov bx, MSG_REAL_MODE
	call print_test
	call print_newln
	
	call load_kernel
	
;	mov bx,DbgPrint
;	call print_test	

	call switch_to_pm	;never returned from here

	jmp $

%include "print_str.asm"
%include "print_str32.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "switchpm.asm"
%include "screen_func.asm"

[bits 16]

;load kernel
load_kernel:
	;call os_clear_screen
	mov bx, MSG_LOAD_KERNEL
	call print_test
	call print_newln
	
	mov bx, KERNEL_OFFSET	;set param for disk load
	mov dh, 15		;load 15 sectors (exclude boot sec)
	mov dl, [BOOT_DRIVE]	;from boot disk to address KERNEL_OFFSET
	call disk_load

	ret

[bits 32]

;arrive here after switching to and initialising protected mode
BEGIN_PM:
	
	mov ebx, MSG_PROT_MODE
	call print_string_pm
	;mov ebx,0xa
	;call print_string_pm

	call KERNEL_OFFSET

	jmp $

;clearsn:
;	mov ax,0xb8000
;	mov es,ax
;	xor di,di
;	xor ax,ax
;	mov cx,2000d
;	cld
;	rep stosw

;Global var
BOOT_DRIVE	db 	0
MSG_REAL_MODE 	db	"Started in 16-bit Real Mode", 0
MSG_PROT_MODE 	db	"Successfully landed in 32-bit Protected Mode",0
MSG_LOAD_KERNEL	db	"Loading kernel into memory.",0
DbgPrint	db	"Reached here.",0

;Bootsec padding
times 510-($-$$) db 0
dw 0xaa55
