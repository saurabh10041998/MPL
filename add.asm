section .data
msg1: db "Input first no" ,0x0A
len1: equ $-msg1
msg2: db "Input second no" ,0x0A
len2: equ $-msg2
msg: db "Result is" ,0x0A
len: equ $-msg
section .bss
a: resb 2
b: resb 2
c: resb 1
section .text 
global main
main:
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall
mov rax,0
mov rdi,1
mov rsi,a
mov rdx,2
syscall
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall
mov rax,0
mov rdi,1
mov rsi,b
mov rdx,2
syscall
mov al,byte[a]
sub al,30H
mov bl,byte[b]
sub bl,30H
add al,bl
cmp al,09H
add al,37H
mov byte[c],al
mov rax,1
mov rdi,1
mov rsi,msg
mov rdx,len
syscall
mov rax,1
mov rdi,1
mov rsi,c
mov rdx,1
syscall
mov rax ,60
mov rdi,0
syscall
