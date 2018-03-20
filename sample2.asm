section .data

fname : db 'name.txt',0			;0 helps to find the file 
warn: db "Sorry file can't be opened",0x0A
len : equ $-warn


section .bss
fd_in : resb 8
buffer : resb 30
len1 : resb 8
	%macro scall 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
	%endmacro


section .text
global main
main:

;***************OPEN THE FILE******************
	mov rax,2       ;2 for open the file
	mov rdi,fname   ;file name....
	mov rsi,2       ;for both operation....
	mov rdx,0777    ;permission to all owner,user,group...
	syscall
	
	;rax return the file descriptor
	mov qword[fd_in],rax
	BT rax,63
	jnc down
	scall 1,1,warn,len
	jmp exit
down:
	mov rax,0
	mov rdi,[fd_in]
	mov rsi,buffer
	mov rdx,30
	syscall
	
	;rax return the no of byte recievd..
	mov qword[len1],rax
	mov rax,1
	mov rdi,1
	mov rsi,buffer
	mov rdx,len1
	syscall

;*************CLOSE THE FILE **********************	
	mov rax,3
	mov rdi,[fd_in]

exit:
	mov rax,60
	mov rdi,0
	syscall	
	

	
	
	

