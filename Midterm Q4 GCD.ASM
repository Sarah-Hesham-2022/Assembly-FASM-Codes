 format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:

   mov ebx,[n]
   mov eax,[m]
   L1:
   mov edx,0
   cmp ebx,0
   je L2
   div ebx
   mov eax,ebx
   mov ebx,edx
   jmp L1

   L2:
   cinvoke printf, f1,eax
   cinvoke scanf, f2, x


exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable

f1 db 'GCD=  %d',0
f2 db '%d',0
x dd ?
m dd 105
n dd 30

section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'






