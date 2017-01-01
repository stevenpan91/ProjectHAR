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

;start include test
mov si, HELLO_MSG
call print_string

mov si, GOODBYE_MSG
call print_string

mov bx, HELLO_MSG
call print_test

mov bx, GOODBYE_MSG
call print_test

;end include test
jmp $

%include "print_str.asm" ;include printstr func

HELLO_MSG:
	db 'Hello, World!', 0

GOODBYE_MSG:
	db 'Goodbye!', 0

;padding and magic number

times 510-($-$$) db 0
dw 0xaa55
