section	.text
global	_start

_start:

	mov	edx,len	;message length
	mov	ecx,msg	;message itself
	mov	ebx,1	;file descriptor stdout
	mov	eax,4	;system call number (sys_write)
	int	0x80	;call kernel

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

section	.data

msg	db 'test',0xa
len	equ $ - msg
msg2	times 100 db 0
