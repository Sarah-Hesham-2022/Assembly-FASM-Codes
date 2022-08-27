format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:

  mov eax,[arr]
 loopsatrt:  mov esi,[i]
 cmp esi,[size]
  je endloop
  mov ecx,[arr+4*esi]
  cmp ecx,[target]
  jne endif
  mov [targetIndex],esi
endif:
inc [i]
jmp loopsatrt

endloop:
    cinvoke printf, f4,[targetIndex]
   cinvoke scanf, f6, x


exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable
arr dd  10,8,7,10,2,1,9
size dd 7
target dd 2
targetIndex dd -1
i dd 1

x dd ?
f4 db 'the target found at index %d',0
f6 db '%d',0



section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'