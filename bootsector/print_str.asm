finish:
	popa
	ret


print_test:
	pusha
	mov ah, 0x0e
	jmp iter2
iter2:
	mov al,[bx]
	cmp al,0
	je finish
	int 0x10
	inc bx
	jmp iter2

print_hex:
	pusha
	mov ah,0x0e ;write to screen
	
	mov bx, '0' ;write 0
	mov al,bl
	int 0x10
	
	mov bx, 'x' ;write x
	mov al,bl
	int 0x10

	mov si,dx	;back up dx
	jmp iterhex ;perform replacement
	
retprhex:
	call print_test ;print string

iterhex:
	mov di,3	;amount of cycles
	jmp ploopstart

ploopstart:
	mov cx,di	;copy di to cx	;cx is 3  ;cx is 2
	shl cx,2	;multiply cx value by 4	;cx is 12 ;cx is 8
	shr dx,cl	;divide dx by cx value	;shift right 12 bits, dx should be 1
			;shift 0fb6 right 8 bits, dx should be 15
	cmp dx,9h	;compare to 9	;dx is 1, skip next step ;dx is f, go to greaterthan9
	jg greater_than_9	;add hex 57 if greater than 9
	add dx,0x30	;add 0x30 if 0 to 9	;add hex 30 to 1
	mov bx,dx	;move dx into bx	;bx is 31h
	mov al,bl	;print digit	;al is 31h
	int 0x10	;		;print 31h
	sub bx,0x30	;		;bx is 1
	jmp postloopcmp

postloopcmp:	
	shl bx,cl	;shift bx left to subtract it	;bx is 1000
	mov dx,si		;restore dx to original 1fb6
	sub dx,bx	;eliminate leftmost digit	;1fb6-1000=0fb6
	mov si,dx	;make si dx without the leftmost digit	si=0fb6
	dec di		;lower cycle value		;di is 2
	cmp di,0					;di is higher than 0
	jge ploopstart	;if cycle is equal to or greater than
			;0 then jump back to loop

	jmp loopend

loopend:
	jmp finish	;pop and exit

greater_than_9:
	add dx,0x57	;add 0x57 if greater than 9 ;add 0x57 to f is f in ascii
	mov bx,dx	;bx is now f
	mov al,bl	;al is f
	int 0x10	;print	should print f
	sub bx,0x57
	jmp postloopcmp

print_newln:
	push ax
	mov ah,2 ;cursor control
	mov bh,0 ;page 0
	mov dl,0 ;column 0
	inc dh   ;increase row number
	int 0x10 ;bios interrupt
	pop ax   ;restore ax
	ret

