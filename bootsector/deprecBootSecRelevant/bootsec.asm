[org 0x7c00]	; tell assembler where load will
		; be loaded



mov ah, 0x0e ;scrolling teletype BIOS

mov bp, 0x8000	;set base of stack
mov sp,bp	;load bootsector

push 'A'
push 'B'
push 'C'

pop bx
mov al,bl
int 0x10

pop bx
mov al,bl
int 0x10

mov al, [0x7ffe]	

int 0x10
call print_newln

mov bx,40
;check if bx is less than equal to 4
cmp bx,4
jle first_cmp ;if it's less than equal to 4 jump to first cmp
cmp bx,40     ;else see if it's less than 40
jl second_cmp ;jump to second_cmp if less than 40
mov al, 'C'   ;Else move C into lower of ax
jmp the_end

first_cmp:	;Move A into lower of ax if bx <= 4
	mov al, 'A'
	jmp the_end

second_cmp:	;Move B into lower of ax if bx < 40
	mov al, 'B'
	jmp the_end

the_end: 	
	;mov ah, 0x0e
	int 0x10
	call print_newln

;start include test
mov si, HELLO_MSG
call print_string
call print_newln

mov si, GOODBYE_MSG
call print_string
call print_newln

mov bx, HELLO_MSG
call print_test
call print_newln

mov bx, GOODBYE_MSG
call print_test
call print_newln

mov dx,0x1fb6
;mov bx, HEX_OUT
call print_hex
call print_newln

;end include test

;start boot drive portion
mov [BOOT_DRIVE], dl	

;stack is set above already
;mov bp, 0x8000
;mov sp,bp
;mov ah,2
;add dh,1
;int 0x10	;move cursor down

mov bx, 0x9000	;load 5 sectors to 0x0000 (ES):0x9000(BX)
mov dh, 5	;from boot disk
mov dl, [BOOT_DRIVE]
call disk_load
call print_newln

;mov ah,2
;add dh,1
;int 0x10	;move cursor down

mov dx, [0x9000]	;print first loaded word
			;should be 0xdada at 0x9000
call print_hex
;call print_newln

mov dx, [0x9000 + 512]	;print first word from 2nd
			;loaded sesctor, should be
			; 0xface
call print_hex
;call print_newln

jmp $

%include "print_str.asm" ;include printstr func
%include "disk_load.asm" ;include disk loader file

BOOT_DRIVE: db 0

HELLO_MSG:
	db 'Hello, World!', 0

GOODBYE_MSG:
	db 'Goodbye!', 0

;HEX_OUT:
	;db '0x0000', 0

;padding and magic number

times 510-($-$$) db 0
dw 0xaa55

;prove that two sectors were loaded
times 256 dw 0xdada
times 256 dw 0xface
