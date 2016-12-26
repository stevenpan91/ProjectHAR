section .text
global _start

_start:

	mov 	rcx,inp1
	call	slen
	;mov 	edx,inplen1
	mov 	rax,4
	mov 	rbx,1
	int	0x80

	;exit
	mov	rax,1
	int	0x80

slen:
	push 	rcx
	mov	rdx,0
	dec	rcx
	count:
		inc	rdx
		inc	rcx
		cmp	byte[rcx],0
		jnz	count
	dec	rdx
	pop	rcx
	ret

section .data
inp1 db 'Input function',0xa
;inplen1 equ $ - inp1
