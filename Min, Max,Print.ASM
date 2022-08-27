format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:

; start print the content of array

mov ecx,[size]
mov eax , 0

startloop:

push ecx
push eax
cinvoke printf, f6 , [array+eax*4]  ;

pop eax

pop ecx

add eax,1

loop startloop  ; if ecx = 0 endloop else dec ecx jmp startloop

;  end print the content of array

cinvoke printf, newline   ; printf new line


 mov ebx , [array]
 mov [min], ebx
 mov [max] , ebx
 startLoop:
        mov eax,[i] ; eax   is   i
        cmp eax,[size]
        jge endloop
        mov ebx , [array+eax*4]

        cmp ebx , [min]
        jge elsex
            mov [min], ebx

        elsex:
          cmp ebx , [max]
          jle endif
           mov [max] , ebx

       endif:

       inc [i]

jmp startLoop
endloop:

cinvoke printf, f4,[min] , [max]


cinvoke scanf, f5, vard

exit:

   invoke ExitProcess, 0;

section '.data' data readable writeable

 f4 db 'the min = %d , the max = %d',0 ; 0 for string termination
 f5 db '%d',0
 f6 db ' %d ',0
 newline db '',10,0  ; newline string
 vard dd ?

array dd  5,0,8,15,2,4,30,20
size  dd 8
min dd ?
max dd ?
i dd 0




section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'