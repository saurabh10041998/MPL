section .data
msg:db "The array is ",0x0A
len:equ $-msg
array:db 0x12,0x13,0x14,0x15,0x16
cnt:db 5
msg1:db"0x12,0x13,0x14,0x15,0x16"
len1: equ $-msg1
msg2: db "MENU",0x0A
      db "1.nonoverlapped without string",0x0A
      db "2.nonoverlapped with string",0x0A
      db "3.overlapped without string",0x0A
      db "4.overlapped with string",0x0A
      db "5.Exit",0x0A
len2:equ $-msg2
cnt1: db 0
space : db 0x20


section .bss
%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro
chioce : resb 2
address: resb 16
a: resb 2


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
pop rsi
mov cl,byte[rsi]
push rsi
call htoa_2         ;call to process
pop rsi
inc rsi
dec byte[cnt]
jnz up

scall 1,1,msg2,len2

;scall 1,1,msg1,len1


;process to convert it in ascii 16 digit no 

htoa_16:
mov rdi,address
mov byte[cnt1],16
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
scall 1,1,address,16
scall 1,1,space,1
ret

;process to convert it in ascii 2 digit no 

htoa_2:
mov rdi,a
mov byte[cnt1],2
up2:
rol rbx,4
mov dl,cl
and dl,0x0F
cmp dl,09H
jbe calc1
add dl,7H
calc1:
add dl,30H
mov byte[rdi],dl
inc rdi
dec byte[cnt1]
jnz up2
scall 1,1,address,16
scall 1,1,space,1
ret

mov rax,60
mov rdi,0
syscall
