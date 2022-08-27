format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:

   mov ecx,[five]
   mov ebx,[nine]
   mov eax,[one]

   L1:
   mul ecx
   add ebx,eax
   dec ebx
   inc eax
   loop L1

   cinvoke printf, f1,ebx
   cinvoke printf,newline
   cinvoke scanf, f2, x


exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable

f1 db 'EBX=   %d',0
f2 db '%d',0
x dd ?
newline db '',10,0
five dd 5
nine dd 9
one dd 1
section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'






