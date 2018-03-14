section .data
msg: db "Array is ",0x0A
len:equ $-msg
msg1:db "No of positive no ",0x0A
len1:equ $-msg1
msg2: db "No of negative no ",0x0A
len2:equ $-msg2
array:dq 0x1234123412341234,0x1234123412341234,0x1234123412341234,0x1234123412341234,0x1234123412341234
msg3:db "0x1234123412341234,0x1234123412341234,0x1234123412341234,0x1234123412341234,0x1234123412341234",0x0A
len3:equ $-msg3
pos:db 0
neg:db 0
count:db 5
section .text
global main
main:
mov rsi,array
up:
mov rax,qword[rsi]
BT ax,15
jc next
inc byte[pos]
add rsi,8
dec byte[count]
jnz up
jmp next1
next:
inc byte[neg]
add rsi,8
dec byte[count]
jnz up
next1:
cmp byte[pos],9
jbe next2
add byte[pos],7H
next2:
add byte[pos],30H
cmp byte[neg],9
jbe next3
add byte[neg],7H
next3:
add byte[neg],30H
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall
mov rax,1
mov rdi,1
mov rsi,pos
mov rdx,1
syscall
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall
mov rax,1
mov rdi,1
mov rsi,neg
mov rdx,1
syscall
mov rax,60
mov rdi,0
syscall



