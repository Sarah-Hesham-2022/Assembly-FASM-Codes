format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:

     ;to print the array before sorting
     cinvoke printf, f2
     mov esi,0
     cinvoke printf,newline
     LPrint0:
     mov eax,[arr+esi*4]
     cinvoke printf,f1,eax
     inc esi
     cmp esi,[size]
     je L0
     jmp LPrint0

     ;this prepares n=size-1
     L0:
     cinvoke printf,newline
     mov eax,-1
     mov ebx,[size]
     dec ebx
     mov [sizeMinus1],ebx

     ;this acts as the first outer for loop in the bubble sort
     L1:
     cmp eax ,[sizeMinus1]
     je LFinal
     inc eax
     mov esi,0
     jmp L3

     ;this prepares j=i-n-1
     L3:
     mov edx,[sizeMinus1]
     sub edx,eax
     mov [newSize],edx
     jmp L2

     ;this acts as the second inner loop in the bubble sort
     L2:
     cmp esi,[newSize]
     je L1
     mov ecx,[arr+esi*4]
     mov ebx,[arr+esi*4+4]
     cmp ecx,ebx
     jg LSwap
     inc esi
     jmp L2

     ;swap function
     LSwap:
     mov [arr+esi*4],ebx
     mov [arr+esi*4+4],ecx
     inc esi
     jmp L2

     ;print array after sorting
     LFinal:
     cinvoke printf, f5
     mov esi,0
     cinvoke printf,newline
     LPrint1:
     mov eax,[arr+esi*4]
     cinvoke printf,f1,eax
     inc esi
     cmp esi,[size]
     je LEnd
     jmp LPrint1

     ;end program by taking input to keep console stand still
     LEnd:
     cinvoke printf,newline
     cinvoke scanf, f6, x

exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable

arr dd 5,8,-11,7,10,4,1,-9  ;my array
size dd 8           ;size of array
sizeMinus1 dd ?     ; i=n-1
newSize dd ?        ;j=n-i-1
x dd ?              ;to make console stand still
f1 db '   %d   ',0  ;to make spaces between elements of the array while being printed
f2 db 'The array before sort: ',0
f5 db 'The array after sort: ',0
f6 db '%d',0
newline db '',10,0  ;new line to print \n


section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'

