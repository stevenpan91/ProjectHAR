section	.text
global	_start

_start:

	mov	edx,len	;message length
	mov	ecx,msg	;message itself
	mov	ebx,1	;file descriptor stdout
	mov	eax,4	;system call number (sys_write)
	int	0x80	;call kernel

	mov	edx,3
	mov	ecx,num1
	mov	ebx,1
	mov	eax,4
	int	0x80
	
	mov	edx,num2le
	mov	esi,5
	add	esi,6
	add	esi,0x30
	;add	esi,0xa
	mov	[num2],esi
	mov	ecx,num2
	mov	ebx,1
	mov	eax,4
	int	0x80
	call	newline

	mov	edx,100
	mov	ecx,msg2
	mov	ebx,0
	mov	eax,3
	int	0x80
	

	mov	edx,100
	mov	ecx,msg2
	mov	ebx,1
	mov	eax,4
	int	0x80	;call kernel


	mov	eax,1	;system call number (sys_exit)
	int	0x80	;call kernel
	ret

newline:
	mov	edx,1
	mov	ecx,newln
	mov	ebx,1
	mov	eax,4
	int	0x80
	ret	

section	.data

msg	db 'test',0xa
len	equ $ - msg
msg2	times 100 db 0
num1	db 0x5a,0xa
num2	times 100 db 0
num2le	equ $ - num2
newln	db 0xa
