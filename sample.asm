section .data
msg1: db "Enter Your Roll no " ,0x0A
len1: equ $-msg1
msg2: db "Roll no is",0x0A
len2: equ $-msg2
section .bss
var:resb 5
section .text
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall
mov rax,0
mov rdi,1
mov rsi,var
mov rdx,5
syscall
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall
mov rax,1
mov rdi,1
mov rsi,var
mov rdx,5
syscall
mov rax,60
mov rdi,0
syscall

