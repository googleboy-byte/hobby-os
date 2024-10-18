
[org 0x7c00]

	mov bp, 0x9000
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_string

	call switch_to_pm

	jmp $

%include "./print/print_string.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 32]

BEGIN_PM:

	mov ebx, MSG_PROT_MODE
	call print_string_pm

	jmp $

MSG_REAL_MODE db "16-bit Real Mode initiated", 0
MSG_PROT_MODE db "Switch completed to 32-bit Protected Mode", 0

times 510-($-$$) db 0
dw 0xaa55