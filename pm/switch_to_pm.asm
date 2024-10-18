[bits 16]

switch_to_pm:

	cli			; switch off interrupts till protected
				; mode interrupt vector is set up
	lgdt [gdt_descriptor] 	; load global descriptor table
	
	mov eax, cr0		; set first bit of cr0 control reg
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_pm	; make far jump to 32bit code
				; force cpu cache flush
				; clearing pre-fetched/real-mode instructions
	
[bits 32]

init_pm:
	
	mov ax, DATA_SEG	; point segment registers
	mov ds, ax		; to data sector
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000	; move stack to top of free space
	mov esp, ebp

	call BEGIN_PM
	