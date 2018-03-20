section .data

menu : db "*********MENU*********",0x0A
	      db " 1.Number of Spaces",0x0A
	      db " 2.Number of lines ",0x0A
	      db " 3.occurance of character (any)",0x0A
	      db " 4.Exit",0x0A
lenm : equ $-menu	

fname : db 'sample.txt',0			;0 helps to find the file 
success : db "FILE IS OPENED SUCCESSFULLY..",0x0A
lens: equ $-success
warn: db "Sorry file can't be opened",0x0A
len : equ $-warn
ans1 : db "Number of the spaces in text ",0x0A
lena1: equ $-ans1
ans2 : db "Number of the lines in text ",0x0A
lena2: equ $-ans2
ans3 : db "Occurance of character = ",0x0A
lena3:equ $-ans3
query : db "Enter the character you want to find",0x0A
lenq : equ $-query

enterkey: db 0x0A

section .bss
	%macro scall 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
	%endmacro
global fd_in,buffer,choice,len1,result,find
fd_in : resb 8
buffer : resb 100
choice : resb 2
len1: resb 8
find: resb 2

result : resb 1



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
	scall 1,1,success,lens
	mov rax,0
	mov rdi,[fd_in]
	mov rsi,buffer
	mov rdx,100
	syscall

	
	;rax return the no of byte recievd..stored in len1 var
	mov qword[len1],rax
menup:
	scall 1,1,menu,lenm
	scall 0,1,choice,2
	cmp byte[choice],31h
	je space
	cmp byte[choice],32h
	je enter
	cmp byte[choice],33h
	je letter
	cmp byte[choice],34h
	jae exit



;*********CALL THE PROCEDURE TO CALCULATE THE NUMBER OF SPACES*******
space:
	extern spacecount
	call spacecount
	scall 1,1,ans1,lena1
	scall 1,1,result,1
	scall 1,1,enterkey,1
	jmp menup
	
;*********CALL THE PROCEDURE TO CALCULATE THE NUMBER OF LINE*******
enter:
	extern entercount
	call entercount
	scall 1,1,ans2,lena2
	scall 1,1,result,1
	scall 1,1,enterkey,1
	jmp menup

;*********CALL THE PROCEDURE TO CALCULATE THE OCCURANCE OF LETTER*****

letter:
	scall 1,1,query,lenq
	scall 0,1,find,2
	extern Acount
	call Acount
	cmp cx,09
	jbe down5
	add cx,07H
down5:
	add cx,30H
	mov byte[result],cl
	scall 1,1,ans3,lena3
	scall 1,1,result,1
	scall 1,1,enterkey,1
	jmp menup

	

;*************CLOSE THE FILE **********************
exit:	
	mov rax,3
	mov rdi,[fd_in]


	mov rax,60
	mov rdi,0
	syscall	
	

	
	
	

