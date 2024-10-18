
[org 0x7c00]

	mov bx , MSG_ONE	; initiate messages
	call print_string 
	mov bx, NEWLINE_CHAR
	call print_string
	mov bx , MSG_TWO
	call print_string
	
	mov [BOOT_DRIVE], dl	; bios stores boot drive in dl
				; so we store dl value in BOOT_DRIVE variable

	mov bp, 0x8000		; stack set safely at x8000
	mov sp, bp

	mov bx, 0x9000		; Load 5 sectors to ES:BX
				; ES is at 0x0000
				; BX is at 0x9000

	mov dh, 5
	mov dl, [BOOT_DRIVE]
	call disk_load

	mov dx, [0x9000]
	call print_hex

	mov dx, [0x9000 + 512]
	call print_hex

	jmp $

%include "./print/print_string.asm"
%include "./hex/print_hex.asm"
%include "disk_load.asm"

; ------------ GLOBAL VARIABLES -----------------

BOOT_DRIVE: db 0

NEWLINE_CHAR:
	db 10, 13, 0 ; ascii -> 10:newline 13:carriagereturn

MSG_ONE:
	db 'Booting', 0

MSG_TWO:
	db 'Initiating BIOS Read sector function', 0

; ------------ GLOBAL VARIABLES END --------------

;boot sector padding

times 510-($-$$) db 0
dw 0xaa55

; load additional sectors from disk

times 256 dw 0xdada
times 256 dw 0xface