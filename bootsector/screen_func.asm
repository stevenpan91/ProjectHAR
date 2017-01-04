;From MikeOS

os_clear_screen:
	pusha
	mov dx,0	;cursor at top left
	jmp os_move_cursor

back1:
	mov ah,6	;scroll full-screen
	mov al,0	;normal white on black
	mov bh,7
	mov cx,0	;top left
	mov dh,24	;bottom right
	mov dl,79
	int 10h
	
	popa
	ret

os_move_cursor:
	pusha

	mov bh,0
	mov ah,2
	int 10h	;bios interrupt move cursor

	popa
	jmp back1
