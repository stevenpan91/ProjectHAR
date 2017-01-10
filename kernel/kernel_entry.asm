[bits 32]
[extern kernel_start] ;declare reference to external symbol main
call kernel_start	;invoke main() in C kernel
jmp $
