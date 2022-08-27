include 'win32ax.inc'
.data
x dw 7
msg db 5 dup(?),0
.code
proc f1
 xor ecx,ecx
 mov cx,[x]
 mov ax,1
L1: mul cx
 loop L1
 shl ax,1
 ret
endp
proc f2
 mov bx,10
 mov ecx,0
L3: xor dx,dx
 div bx
 add dl,48
 push dx
 inc ecx
 cmp ax,0
 jz L4
 jmp L3
L4: lea edi, [msg]
 cld
L5: pop ax
 stosb
 loop L5
 ret
endp
start:
 call f1
 call f2
 invoke MessageBox,0, msg,"Welcome",0
 invoke ExitProcess,0
.end start