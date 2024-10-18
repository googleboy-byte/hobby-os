[bits 32]

VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:		; prints null-terminated string pointed to by EDX
	pusha
	mov edx, VIDEO_MEM

print_string_pm_loop:
	mov al, [ebx]
	mov ah, WHITE_ON_BLACK	; store attributes in AH
	
	cmp al, 0		; check null terminateion
	je print_string_pm_done

	mov [edx], ax
	
	add ebx, 1		; increment ebx to next char in str
	add edx, 2		; move to next char cell in vid mem

	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret