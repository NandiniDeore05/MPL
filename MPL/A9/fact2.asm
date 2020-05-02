;non recursive
section .data
msg: db "Factorial is 1",0x0A
len: equ $-msg
msg1: db " ",0x0A
len1: equ $-msg1
msg2: db "Factorial is:"
len2: equ $-msg2
count: db 00
count1: db 00

section .bss
num: resq 1
result: resb 16
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
pop rbx
pop rbx
pop rbx
mov [num],rbx
call AtoH
cmp bl,00
je exit
cmp bl,01
je exit
scall 1,1,msg2,len2
scall 1,1,msg1,len1
mov rdx,00
mov rdx,rbx
up2:	inc byte[count1]
	push rbx
	dec rbx
	jnz up2

mov rax,01
up3:	pop rbx
	mul rbx
	dec byte[count1]
	jnz up3

mov rdx,rax
call HtoA
mov rax,60
mov rdx,3
syscall


exit:	scall 1,1,msg,len
	scall 1,1,msg1,len1
	mov rax,60
	mov rdx,3
	syscall


AtoH:
mov rsi,qword[num]
mov rbx,00
mov rdx,00
mov byte[count],02
up:	rol bl,04
	mov dl,byte[rsi]
	cmp dl,39H
	jbe down
	sub dl,07
down:	sub dl,30H
	add bl,dl
	mov dl,00
	inc rsi
	dec byte[count]
	jnz up
	ret


HtoA:
mov rsi,result
mov rcx,00
mov byte[count],16
up1:	rol rdx,04
	mov cl,dl
	and cl,0FH
	cmp cl,09
	jbe down1
	add cl,07
down1:	add cl,30H
	mov byte[rsi],cl
	inc rsi
	dec byte[count]
	jnz up1
	scall 1,1,result,16
	scall 1,1,msg1,len1
	ret
