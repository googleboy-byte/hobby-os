print_string:
	pusha ; load registers to stack
	mov ah, 0x0e ; set teletype

print_actual:
	mov al, [bx] ; move one byte from value in bx register to al
	cmp al, 0 ; check if string is null terminated
	je terminate_print ; if val is 0, terminate print function
	int 0x10 ; else call interrupt to print
	add bx, 1 ; increment bx register by 1 to change its contents to the next value in memory
	jmp print_actual ; loop

terminate_print:
	popa ; restore stack
	ret ; return