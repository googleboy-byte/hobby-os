gdt_start:

gdt_null:
	dd 0x0
	dd 0x0

gdt_code:

	dw 0xffff	; Limit(bits 0-15)
	dw 0x0		; Base bits 0 15
	db 0x0		; Base bits 16 23
	db 10011010b	; 1st flags, type flags
	db 11001111b	; 2nd flags Limit bits 16 19
	db 0x0		; Base bits 24 31

gdt_data:

	dw 0xffff 	; Limit ( bits 0 -15)
	dw 0x0 		; Base ( bits 0 -15)
	db 0x0 		; Base ( bits 16 -23)
	db 10010010b 	; 1st flags , type flags
	db 11001111b 	; 2nd flags , Limit ( bits 16 -19)
	db 0x0 		; Base ( bits 24 -31)

gdt_end:		; gdt end is present for assembler to be able to 
			; calculate the size of the gdt for the descriptor

gdt_descriptor:

	dw gdt_end - gdt_start - 1	; gdt size always less one of true size
	dd gdt_start			; start address of gdt

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start	; some constants for gdt seg descriptor offsets