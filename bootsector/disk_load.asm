;load DH sectors to ES:BX from drive DL
disk_load:
	push dx	;store DX on stack
	mov ah, 0x02	;BIOS read sector function
	mov al, dh	;read DH sectors
	mov ch, 0x00; Select cylinder 0
	mov dh, 0x00	;select head 0
	mov cl, 0x02	; Read from second sector

	int 0x13	;BIOS interrupt

	jc disk_error	;jump for carry flag set
	
	pop dx		;restore dx
	cmp dh,al	;if AL != DH
	jne disk_error	;display error
	ret

disk_error:

	mov bx, DISK_ERROR_MSG
	call print_test
	jmp $

; Vars
DISK_ERROR_MSG	db 'Disk read error!',0	
