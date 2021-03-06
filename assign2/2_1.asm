section .data
msg:db "The array is ",0x0A
len:equ $-msg
array:dq 0x1234567890124569,0x13ABCDEFCDEA1478,0x149874563210CDEA,0x1510230123654789,0x169630258741ABCD
cnt:db 5
msg1:db"0x1234567890124569,0x13ABCDEFCDEA1478,0x149874563210CDEA,0x1510230123654789,0x169630258741ABCD",0x0A
len1: equ $-msg1
msg2: db "MENU",0x0A
      db "1.nonoverlapped without string",0x0A
      db "2.nonoverlapped with string",0x0A
      db "3.overlapped without string",0x0A
      db "4.overlapped with string",0x0A
      db "5.Exit",0x0A
len2:equ $-msg2
msg3:db "block transfer done ",0x0A
len3:equ $-msg3
msg4:db ":"
len4:equ $-msg4
cnt1: db 0
space:db 0x20
enter:db 0x0A
comma : db 0x2C
cnt2 : db 0


section .bss
%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

choice : resb 2
address: resb 16
a: resb 17
array2: resb 50


section .text
global main
main:
	
	scall 1,1,msg,len
	;printitng the array with address
	mov rsi,array
	mov byte[cnt],5
up:
	mov rbx,rsi
	push rsi
	call htoa_16     ;call to process
	scall 1,1,space,1
	pop rsi
	mov rbx,qword[rsi]
	push rsi
	call htoa_16         ;call to process
	scall 1,1,enter,1
	pop rsi
	add rsi,8
	dec byte[cnt]
	jnz up

	
select:	scall 1,1,msg2,len2
	
	scall 0,1,choice,2

	

	cmp byte[choice],31h
	je option1
	cmp byte[choice],32h
	je option2
	cmp byte[choice],33h
	je option3
	cmp byte[choice],34h
	je option4
	cmp byte[choice],35h
	je exit
option1:
	;non-overlpped block transfer without string

	mov rsi,array
	mov rdi,array+42
	mov byte[cnt],5
up3:
	mov rax,qword[rsi]
	mov qword[rdi],rax
	add rsi,8
	add rdi,8
	dec byte[cnt]
	jnz up3

	scall 1,1,msg3,len3

	


;printing the transferred array...
print:
	mov rsi,array
	mov byte[cnt],5
up4:
	mov rbx,rsi
	push rsi
	call htoa_16     ;call to process
	scall 1,1,space,1
	pop rsi
	mov rbx,qword[rsi]
	push rsi
	call htoa_16         ;call to process
	scall 1,1,enter,1
	pop rsi
	add rsi,8
	dec byte[cnt]
	jnz up4
	

	mov rsi,array+42
	mov byte[cnt],5
up5:
	mov rbx,rsi
	push rsi
	call htoa_16     ;call to process
	scall 1,1,space,1
	pop rsi
	mov rbx,qword[rsi]
	push rsi
	call htoa_16         ;call to process
	scall 1,1,enter,1
	pop rsi
	add rsi,8
	dec byte[cnt]
	jnz up5
	jmp select

option2:
	;nonoverlapped tranfer with string instruction...
	mov rsi,array
	mov rdi,array+42
	mov cx,0x05
	cld
continue:
	movsq
	dec cx
	jnz continue

	scall 1,1,msg3,len3

	jmp print
option3:
	;overlapped transfer without string instruction....
	mov rsi,array
	mov rdi,array2
	mov byte[cnt],05
up6:
	mov rax,qword[rsi]
	mov qword[rdi],rax
	add rsi,8
	add rdi,8
	dec byte[cnt]
	jnz up6


	mov rsi,array2
	mov rdi,array+24
	mov byte[cnt],05
up7:
	mov rax,qword[rsi]
	mov qword[rdi],rax
	add rsi,8
	add rdi,8
	dec byte[cnt]
	jnz up7

	scall 1,1,msg3,len3
	
	;print the overlapped transfer no....
print1:
	mov rsi,array
	mov byte[cnt],8
up8:
	mov rbx,rsi
	push rsi
	call htoa_16
	scall 1,1,space,1
	pop rsi
	mov rbx,qword[rsi]
	push rsi
	call htoa_16
	scall 1,1,enter,1
	pop rsi
	add rsi,8
	dec byte[cnt]
	jnz up8
	jmp select

option4:
;overlapped string transfer with string instruction...
	mov rsi,array
	mov rdi,array2
	mov byte[cnt],5
	cld
continue1:
	movsq
	dec byte[cnt]
	jnz continue1
	
	mov rsi,array2
	mov rdi,array+24
	mov byte[cnt],5
	cld
continue2:
	movsq
	dec byte[cnt]
	jnz continue2
	jmp print1
	





;process to convert it in ascii 16 digit no 

htoa_16:
	mov rdi,address
	mov byte[cnt1],10h
up1:
	rol rbx,4
	mov dl,bl
	and dl,0x0F
	cmp dl,09H
	jbe calc
	add dl,7H
calc:
	add dl,30H
	mov byte[rdi],dl
	inc rdi
	dec byte[cnt1]
	jnz up1

	scall 1,1,address,10h	
	

ret

;process to convert it in ascii 2 digit no 


exit:
	mov rax,60
	mov rdi,0
syscall
