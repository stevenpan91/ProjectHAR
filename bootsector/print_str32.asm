[bits 32]
;define constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY

print_string_pm_loop:
	mov al, [ebx]		;Store char at ebx in AL
	mov ah, WHITE_ON_BLACK  ;Store attributes in ah

	cmp al,0	;jump to done if al==0 EOS
	je end32

	mov [edx], ax	;store char+attr at current
			;char cell

	add ebx,1	;inc ebx to next char
	add edx,2	;move to next char cell in vid mem

	jmp print_string_pm_loop


end32:
	popa
	ret



