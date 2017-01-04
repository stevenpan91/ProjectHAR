[bits 32]
[extern main] ;declare reference to external symbol main
call main	;invoke main() in C kernel
jmp $
