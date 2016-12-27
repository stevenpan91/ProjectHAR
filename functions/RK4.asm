section .text
global _start

_start:
	mov 	rcx,inp1 ;message prompt to input function
	call	slen
	;mov 	edx,inplen1
	mov 	rax,4	;system print
	mov 	rbx,1	
	int	0x80	;call kernel

	mov	rcx,thefunction
	mov	rdx,100
	mov	rax,3	;system input
	mov	rbx,0	
	int	0x80

	mov	rcx,thefunction	;test print function
	call	slen
	mov	rax,4
	mov	rbx,1
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
thefunction times 100 db 0	;initiate function with 100 bytes set to 0
;inplen1 equ $ - inp1
