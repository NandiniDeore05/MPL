section .data
msg1: db "No. of enters : ",0x0A
len1: equ $-msg1
msg2: db "No. of spaces : ",0x0A
len2: equ $- msg2
msg3: db "Enter a character : ",0x0A
len3: equ $-msg3
msg4: db "No. of occurances : ",0x0A
len4: equ $-msg4
count: db 0
cnt2: db 0

section .bss
result :resb 8
c: resb 2
extern length,buffer,temp
%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
global main1
main1:

global enter,space,occurance
enter:
scall 1,1,msg1,len1
mov byte[count],0
mov rsi,buffer
loop1:

cmp byte[rsi],0x0A
jne next
inc byte[count]
next:
add rsi,1
dec qword[length]
jnz loop1
mov dl,byte[count]
call htoA

ret

space:

scall 1,1,msg2,len2
mov byte[count],0
mov rsi,buffer
loop2:

cmp byte[rsi],0x20
jne next1
inc byte[count]
next1:
add rsi,1
dec qword[length]
jnz loop2
mov dl,byte[count]
call htoA

ret

occurance:

scall 1,1,msg3,len3
scall 0,1,c,2
mov al,byte[c]
mov byte[count],0
mov rsi,buffer
loop3:

cmp byte[rsi],al
jne next3
inc byte[count]
next3:
add rsi,1
dec qword[length]
jnz loop3
mov dl,byte[count]
call htoA

ret

htoA:
mov rsi,result
mov byte[cnt2],2
up2:
rol dl,04
mov cl,dl
and cl,0FH
cmp cl,09H
jbe next2
add cl,07H
next2: add cl,30H
mov byte[rsi],cl
inc rsi
dec byte[cnt2]
jnz up2

mov rax,1
mov rdi,1
mov rsi,result
mov rdx,2
syscall

ret




