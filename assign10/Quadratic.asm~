;********DATA section ***********
ff1 : db " %lf +i %lf ",10,0
ff2 : db " %lf -i %lf ",10,0

formatpf : db "%lf",10,0
formatsf : db "%lf",0
four : dq 4      ;for 4ac
two : dq 2       ;for 2a
rmsg : db 0x0A,"Roots are real.Roots : ",0x0A
rmsg_len : equ $-rmsg
imsg: db 0x0A,"Roots are imaginary.Roots : ",0x0A
imsg_len: equ $-imsg
title : db "======Qudratic equation ========",0x0A
	db "Enter a,b,c " ,0x0A
title_len : equ $-title

;******** BSS section ************
section .bss
	;****PRINTF**************
	%macro myprintf 1
	mov rdi,formatpf	;data type is input to the rdi
	sub rsp,8		;create space on stack to store printing value (64 bit = 8 place)
	movsd xmm0,[%1]		;value to be printed given to xmm (128 bit ) register
	mov rax,1		;No of xmm register used
	call printf		;call to printf function 
	add rsp,8		;restore old stack pointer..
	%endmacro

	;******SCANF*************
	%macro myscanf 1
	mov rdi,formatsf	;data type to the rdi register
	mov rax,0		;No of the xmm register used
	mov rsi,%1		;accepted value stored
	call scanf 		;call scanf function to accept value
	%endmacro

	;*****normal SYSCALL******
	%macro scall 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
	%endmacro
;*****DATA MEMBER**********
a: resb 8
b: resb 8
c: resb 8
b2: resb 8		;b square
fac : resb 8		;4 a c
delta: resb 8           ;delta value
rdelta: resb 8		;root of the delta
r1: resb 8		;root1
r2: resb 8 		;root2
ta:resb 8		;2*a
realn: resb 8		;real part 
img1 : resb 8

section .text
	extern printf,scanf
global main
main:
	scall 1,1,title,title_len
	;-----Scanning the number-------
	myscanf a
	myscanf b
	myscanf c
	
	;***calculating b square
	finit 
	fldz
	fld qword[b]
	fmul qword[b]
	fstp qword[b2]
	
	;***calculating 4ac
	fild qword[four]
	fmul qword[a]
	fmul qword[c]
	fstp qword[fac]

	;***calculating delta
	fld qword[b2]
	fsub qword[fac]
	fstp qword[delta]

	;calculating 2a
	fild qword[two]
	fmul qword[a]
	fstp qword[ta]

	btr qword[delta],63		;status of the delta
	jc imaginary
;**************Real roots calculation***************
real:
	scall 1,1,rmsg,rmsg_len

	fld qword[delta]
	fsqrt
	fstp qword[rdelta]
	
	;***** r1 = (-b + sqrt(delta))/2a
	fldz
	fsub qword[b]
	fadd qword[rdelta]
	fdiv qword[ta]
	fstp qword[r1]
	myprintf r1
	
	;***** r2 = (-b-sqrt(delta))/2a
	fldz
	fsub qword[b]
	fsub qword[rdelta]
	fdiv qword[ta]
	fstp qword[r2]
	myprintf r2

	jmp exit

;*********Imaginary root calculation ****************
imaginary:
	scall 1,1,imsg,imsg_len
	
	fld qword[delta]
	fsqrt
	fstp qword[rdelta]

	;******Real part of root
	fldz
	fsub qword[b]
	fdiv qword[ta]
	fstp qword[realn]

	;******Imaginary part of root
	fldz
	fld qword[rdelta]
	fdiv qword[ta]
	fstp qword[img1]

	;***printing the imaginary roots
	mov rdi,ff1
	sub rsp,8
	movsd xmm0,[realn]
	movsd xmm1,[img1]
	mov rax,2
	call printf
	add rsp,8

	mov rdi,ff2
	sub rsp,8
	movsd xmm0,[realn]
	movsd xmm1,[img1]
	mov rax,2
	call printf
	add rsp,8

	jmp exit

;*******exit systemcall 
exit:
	mov rax,60
	mov rdi,0
	syscall







