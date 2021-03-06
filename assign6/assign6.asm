section .data
msg : db "Working mode",0x0A
len : equ $-msg
msg1 : db "linear base address of GDT",0x0A
len1 : equ $-msg1
msg2 : db "protected mode",0x0A
len2 : equ $-msg2
msg3 : db "real mode",0x0A
len3 : equ $-msg3
msg4: db "LIMIT OF THE GDT",0x0A
len4:equ $-msg4
msg5: db "linear base address  of IDTR",0x0A
len5: equ $-msg5
msg6: db "LIMIT OF THE IDT",0x0A
len6:equ $-msg6
msg7:db "CONTENT OF THE LDTR",0x0A
len7:equ $-msg7
msg8:db "CONTENT OF THE TR",0x0A
len8:equ $-msg8
msg9: db "CONTENT OF THE MSW",0x0A
len9: equ $-msg9


cnt : db 0
enter: db 0x0A


section .bss
	%macro scall 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
	%endmacro
gdt : resb 6
idt : resb 6
ldt : resb 2
msw :resb 4
res : resb 4



section .text
global main
main:
	scall 1,1,msg,len
	mov dx,0X0000
	smsw eax
	BT ax,0
	jz down
	scall 1,1,msg2,len2
	
	jmp gdts
down:
	scall 1,1,msg3,len3
;*******************CONTENT OF MSW***************************
gdts:
	scall 1,1,msg9,len9
	smsw eax
	mov dword[msw],eax
	mov rsi,msw+2
	call htoa
	mov rsi,msw
	call htoa
	scall 1,1,enter,1


;***************************CONTENT OF GDTR ***********************

	sgdt [gdt]
	scall 1,1,msg1,len1
	mov rsi,gdt+4
	mov ax,word[rsi]
	call htoa
	mov rsi,gdt+2
	mov ax,word[rsi]
	call htoa
	scall 1,1,enter,1
	scall 1,1,msg4,len4
	mov rsi,gdt
	mov ax,word[rsi]
	call htoa
	scall 1,1,enter,1
	;jmp exit

;****************************CONTENT OF IDTR ***********************

idts:
	sidt [idt]
	scall 1,1,msg5,len5
	mov rsi,idt+4
	mov ax,word[rsi]
	call htoa
	mov rsi,idt+2
	mov ax,word[rsi]
	call htoa
	scall 1,1,enter,1
	scall 1,1,msg6,len6
	mov rsi,idt
	mov ax,word[rsi]
	call htoa
	scall 1,1,enter,1
	;jmp exit

;***********************CONTENT OF LDTR************************

	scall 1,1,msg7,len7
	sldt ax
	call htoa
	scall 1,1,enter,1
	
;***********************CONTENT OF TR*************************

	scall 1,1,msg8,len8
	str ax
	call htoa
	scall 1,1,enter,1
	
	
		

exit:
	mov rax,60
	mov rdi,0
	syscall

;*************************HEX to ASCII ****************************
htoa:
	mov rdi,res
	mov byte[cnt],4
up:
	rol ax,4
	mov bl,al
	and bl,0x0F
	cmp bl,09H
	jbe next
	add bl,07H
next:
	add bl,30H
	mov byte[rdi],bl
	inc rdi
	dec byte[cnt]
	jnz up
	scall 1,1,res,4
	ret

	

