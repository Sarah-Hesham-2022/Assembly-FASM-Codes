;Sarah Hesham Mahmoud 

 format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable


start:

   ;call my functions

   ;Print array before sorting
   cinvoke printf,f2
   push [size]
   push arr
   call PrintArray

   ;sort array
   push [size]
   push arr
   call BubbleSort

   ;print array after sorting
   cinvoke printf,f3
   push [size]
   push arr
   call PrintArray

   ;to keep console running
   cinvoke scanf,f4,x


exist:

   invoke ExitProcess, 0;


section '.data' data readable writeable

arr dd 5,8,11,7,10,4,1,9  ;my array
size dd 8                 ;size of array
sizeMinus1 dd ?           ; i=n-1
newSize dd ?              ;j=n-i-1
x dd ?                    ;to make console stand still
f1 db '   %d   ',0        ;to make spaces between elements of the array while being printed
f2 db 'The array before sort: ',0
f3 db 'The array after sort: ',0
f4 db '%d',0
newline db '',10,0        ;new line to print \n


section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'



BubbleSort:

      push ebx
      push esi
      push edi
      ;Save the registers
      ;by pushing them to be just after the return address that gets added automatically to the stack as I know that the ret statement will pop all arguments of function just before return address and uses the return address at the top of stack to jump so I must keep it at the top and beneath it the registers then continue my normal flow of implementation

      push ebp     ;add ebp to the stack at end
      mov ebp,esp  ;copy esp to ebp to iterate over the stack without changing esp

      mov ebp,[esp+20]  ;base index of my array as satck now has ebp+edi+esi+ebx+returnAddress so our base array is at [5*4+esp]

     ;this prepares n=size-1
     L0:
     mov eax,-1
     mov ebx,[esp+24]    ;push array size to ebx, which is now on top of stack as I pushed it first
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
     mov ecx,[ebp+esi*4]
     mov ebx,[ebp+esi*4+4]
     mov edi,eax ;to temporarly store value of eax as I am using it in bubble sort and at the same time it is the return of function compare
     push ecx
     push ebx
     call compare
     cmp eax,1
     je LSwap
     mov eax,edi  ;to get eax back
     inc esi
     jmp L2

     ;swap function
     LSwap:
     mov eax,edi   ;to get eax back
     mov [ebp+esi*4],ebx
     mov [ebp+esi*4+4],ecx
     inc esi
     jmp L2

      LFinal:
      pop ebp   ;make esp point at return address and remove ebp from stack
     ;bring back the registers
     ;poping by the opposite of pushing
      pop edi
      pop esi
      pop ebx
      mov eax,[esp+4] ;as convention is to have return in eax, incase user needed the array after sort it, if we want our function to be void we can delete this line
      ret 8  ;clear stack from array so, now on top is return address





compare:

      ;No need to save the registers ebx,esi,edi as I am not using them here so no change

      push ebp     ;add ebp to the stack at end
      mov ebp,esp  ;copy esp to ebp to iterate over the stack without changing esp

      mov ebp,[esp+8] ;second argument
      cmp [esp+12],ebp ;first argument
      jg LG
      jle LL

      LG:
      mov eax,1 ;since convention is to return in eax
      pop ebp   ;make esp point at return address and remove ebp from stack
      ret 8  ;clear stack from arguments so, now on top is return address

      LL:
      mov eax,0   ;since convention is to return in eax
      pop ebp   ;make esp point at return address and remove ebp from stack
      ret 8  ;clear stack from arguments so, now on top is return address



PrintArray:

      push esi
      ;Save the register esi but not edi or ebx as I am using them here
      ;by pushing them to be just after the return address that gets added automatically to the stack as I know that the ret statement will pop all arguments of function just before return address and uses the return address at the top of stack to jump so I must keep it at the top and beneath it the registers then continue my normal flow of implementation

     cinvoke printf,newline
     mov esi,0
     push ebp     ;add ebp to the stack at end
     mov ebp,esp  ;copy esp to ebp to iterate over the stack without changing esp

     mov ebp,[esp+12]  ;base index of my array as satck now

     mov ebx,[esp+16]       ;push array size to ebx, which is now on top of stack as I pushed it first

     LPrint:
     mov ecx,[ebp+esi*4]
     cinvoke printf,f1,ecx
     inc esi
     cmp esi,ebx
     jl LPrint

     cinvoke printf,newline
     pop ebp   ;make esp point at return address and remove ebp from stack
     ;bring back the registers
     ;poping by the opposite of pushing
      pop esi
      mov eax,[esp+4] ;as convention is to have return in eax, incase user needed the array after sort it, if we want our function to be void we can delete this line
      ret 8 ;clear stack from array so, now on top is return address


