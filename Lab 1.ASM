format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:
mov eax,10
mov ebx,20
add eax,ebx

    cinvoke printf, f1,eax
   cinvoke scanf, f6, x


exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable

f1 db 'example of string %d',0
f6 db '%d',0
x dd ?


section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'






