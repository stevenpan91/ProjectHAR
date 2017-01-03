[bits 32]
;define constants
VIDEO_MEMORY equ 0xb8000

print_string:
	pusha
	mov ah, 0x0e
	
iter:
	lodsb
	cmp al,0
	je finish	;return func if null
	int 0x10	;otherwise print it
	jmp iter

finish:
	popa
	ret


print_test:
	pusha
	mov ah, 0x0e

iter2:
	mov al,[bx]
	cmp al,0
	je finish
	int 0x10
	inc bx
	jmp iter2

