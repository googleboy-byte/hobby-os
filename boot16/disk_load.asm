; load DH sectors to ES:BX from drive DL

disk_load:

	push dx		; store dx on stack to recall how many sectors were requested to be read
	mov ah, 0x02	; BIOS read sector function
	mov al, dh	; read dh sectors
	mov ch, 0x00	; select cylinder 0
	mov dh, 0x00	; select head 0
	mov cl, 0x02	; start read from second sector, after the boot sector
	int 0x13	; bios interrupt to read disk

	jc disk_error	; if carry flag in cf reg set, jump

	pop dx		; retrieve dx from  stack to see if number of sectors in al (sectors successfully read) match the number of sectors originally requested
	
	cmp dh, al
	jne disk_error	; if not match, raise disk error

	ret

disk_error:
	
	mov bx, DISK_ERROR_MSG
	call print_string

DISK_ERROR_MSG db "Disk read error. Failed to read disk!!!", 0

