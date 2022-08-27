format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:

    mov eax,[arr]
    mov [min],eax
    mov [max],eax
    mov esi,[i]

    L1:
    cmp esi,[size]
    je L2
    mov eax,[arr+esi*4]
    inc esi
    cmp eax,[min]
    jl LMin
    jmp LMax
    jmp L1

    LMin:
    mov [min],eax
    jmp L1

    LMax:
     cmp eax,[max]
     jg LMax2
     jmp L1

   LMax2:
   mov [max],eax
   jmp L1

    L2:
    mov eax,[min]
    mov [sum],eax
    mov ebx,[max]
    add [sum],ebx

    mov ecx,[size]
    mov esi,0

    cinvoke printf, f5
    cinvoke printf,newline
    LoopPrint:
    cmp esi,[size]
    je LFinal
    mov eax,[arr+esi*4]
    inc esi
    cinvoke printf,f1,eax
    jmp LoopPrint

    LFinal:
    cinvoke printf,newline
    cinvoke printf, f4 ,[min]
    cinvoke printf, f3,[max]
    cinvoke printf, f2,[sum]
    cinvoke scanf, f6, x


exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable
arr dd  2,5,8,7,9,10,-9,100
size dd 8
i dd 1
sum dd ?
min dd ?
max dd ?
x dd ?
f1 db '  %d  ',0
f2 db ' = %d',0
f3 db '  +  %d',0
f4 db 'The sum of the min and max elements of the array is  %d',0
f5 db 'The array content is :',0
f6 db '%d',0
newline db '',10,0  ; newline string


section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'