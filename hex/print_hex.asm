TABLE:
	db "0123456789ABCDEF", 0

print_hex:
	pusha
	jmp hex_to_char

hex_to_char:
	
	push bx

	mov bx, TABLE
	mov ax, dx

	mov ah, al
	shr ah, 4
	and al, 0x0F

	xlat
	xchg ah, al
	xlat

	mov bx, STRING
	xchg ah, al
	mov [bx], ax

	pop bx
	jmp terminate_hex

terminate_hex:
	popa
	ret

STRING:
	db '0x0000'

mov bx, [STRING]
call print_string1

print_string1:
	pusha ; load registers to stack
	mov ah, 0x0e ; set teletype
	jmp print_actual1

print_actual1:
	mov al, [bx] ; move one byte from value in bx register to al
	cmp al, 0 ; check if string is null terminated
	je terminate_print1 ; if val is 0, terminate print function
	int 0x10 ; else call interrupt to print
	add bx, 1 ; increment bx register by 1 to change its contents to the next value in memory
	jmp print_actual1 ; loop

terminate_print1:
	popa ; restore stack
	ret ; return
