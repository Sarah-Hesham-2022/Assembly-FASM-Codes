format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:

   mov eax,[y]
   mov ebx,[x]
   L1:
   cmp ebx,eax
   jge L2
   inc ebx
   mul ebx
   div [w]
   jmp L1

   L2:
   mov [x],ebx
   mov [y],eax
   cinvoke printf, f1 ,[x]
   cinvoke printf, newline
   cinvoke printf,f2,[y]
   cinvoke printf, newline
   cinvoke scanf, f2, z


exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable

f1 db 'X=  %d',0
f2 db 'Y=  %d   ',0
z dd ?
x dd 1
y dd 10
w dd 4
newline db '',10,0
section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'


;int x=1;int y=10;
; while(x<y)
; {
;    x++;
;   y*=x;
;  y/=4;
; }
; cout<<"x "<<x<<" y "<<y<<endl;



