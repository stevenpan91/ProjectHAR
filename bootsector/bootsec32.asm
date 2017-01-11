[org 0x7c00]
KERNEL_OFFSET equ 0x1000
	mov [BOOT_DRIVE], dl ;BIOS stores boot drive in DL

	mov bp, 0x9000	;set stack
	mov sp, bp
	
	
	;clear screen
	call clearsn

	mov bx, MSG_REAL_MODE
	call print_test
	
	call print_newln
	
	call load_kernel
	

	call switch_to_pm	;never returned from here

	jmp $

%include "bootsector/print_str.asm"
%include "bootsector/print_str32.asm"
%include "bootsector/disk_load.asm"
%include "bootsector/gdt.asm"
%include "bootsector/switchpm.asm"
;%include "screen_func.asm"

[bits 16]

;load kernel
load_kernel:
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
	;move cursor
	
	push cx	      ;Going to make use of cx for storing offset
	mov cx,321    ;offset val col:0 row:2
	out 0x3D4, 14 ;port byte 14 to port 0x3D4 (REG SCREEN CTRL)
	shr cx, 8     ;shift cx right 8
	out 0x3D5, cx   ;then store to port 0x3D5 which is REG SCREEN DATA
	out 0x3D4, 15 ;port byte 15 to port 0x3D4
	out 0x3D5, cx    ;offset value to port 0x3D5
	
	mov ebx, MSG_PROT_MODE
	call print_string_pm


	call KERNEL_OFFSET
	
	jmp $

clearsn:
	;set cursor far below to clear screen
	push ax
	mov ah,2
	mov bh,0
	mov dh,40
	mov dl,0
	int 0x10	
	pop ax
	
	
	;clear screen
	push bp
	mov bp,sp    ;move top of stack pointer to base pointer
	pusha

	mov ah, 0x07 ;bios scroll down window
	mov al, 0x00 ;clear window
	mov bh, 0x07 ;white on black
	mov cx, 0x00 ;top left of screen
	mov dh, 0x18 ;24 rows
	mov dl, 0x4f ;79 columns
	int 0x10     ;vid interrupt

	popa
	mov sp,bp
	pop bp

	push ax
	mov ah,2 ;move cursor call
	mov bh,0 ;page 0
	mov dx,0 ;cursor at 0x0
	int 0x10
	pop ax
	ret

;Global var
BOOT_DRIVE	db 	0
MSG_REAL_MODE 	db	"Init 16-bit Real Mode", 0
MSG_PROT_MODE 	db	"Init 32-bit Protected Mode",0
MSG_LOAD_KERNEL	db	"Loading kernel to memory.",0
DbgPrint	db	"Reached here.",0

;Bootsec padding
times 510-($-$$) db 0
dw 0xaa55
