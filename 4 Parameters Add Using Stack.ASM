format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:
  ;this to test if I managed to save the 3 registers
   mov ebx,1000
   mov esi,2000
   mov edi,3000

   push 10 ;first argument
   push 20 ;second argument
   push 30 ;third argument
   push 40 ;fourth argument
   call MyAdd4 ;call my function

   cinvoke printf, f1,eax
   cinvoke printf,newline
   cinvoke printf, f3,ebx
   cinvoke printf,newline
   cinvoke printf, f4,esi
   cinvoke printf,newline
   cinvoke printf, f5,edi
   cinvoke printf,newline
   cinvoke scanf, f2, x


exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable

f1 db 'Total sum is : =     %d',0
f2 db '%d',0
f3 db 'Value of ebx is : =  %d',0
f4 db 'Value of esi is : =  %d',0
f5 db 'Value of edi is : =  %d',0
newline db '',10,0  ;new line to print \n
x dd ?

;It is the responsibility of the callee to save the registers ebx,edi,esi and I am the coder so let us save them my pushing and poping to the stack and printing to test

;our high level code of the function:
;int MyAdd4(int x,int y,int z,int w){
;int m=x+y; int n=z+w;
;return m+n;
;}

;imagine the stack
MyAdd4:

      push ebx
      push esi
      push edi
      ;Save the registers
      ;by pushing them to be just after the return address that gets added automatically to the stack as I know that the ret statement will pop all arguments of function just before return address and uses the return address at the top of stack to jump so I must keep it at the top and beneath it the registers then continue my normal flow of implementation

      push ebp     ;add ebp to the stack at end
      mov ebp,esp  ;copy esp to ebp to iterate over the stack without changing esp
      sub esp,8    ;like pushing 2 elements to satck ,it must be sub esp,8 ; to allocate 2 positions on stack. stack grow from top to bottom as we discussed
      mov ebx,[ebp+20]  ;move first argument to ebx
      add ebx,[ebp+24] ;add first argument to second argument
      mov [ebp-8],ebx   ;move the result of addition of the first 2 arguments to last element pushed in stack
      mov ebx,[ebp+28]  ;move 3rd argument to ebx
      add ebx,[ebp+32]  ;add 4th and 3rd arguments
      mov [ebp-4],ebx   ;store 4th and 3rd arguments addition result in second element in stack from bottom pushed at beginning of function lines
      add ebx,[ebp-8]   ;store the result of addition of the last 2 elements of the stack in ebx
      mov eax,ebx       ;move the final result to eax as in Intel86 convention the last value returned is known to be in eax
      add esp,8        ;make stack point at ebp, i.e. remove or pop what you pushed, i.e. the 2 elements in which you were adding the result temporarly ,add esp,8 ; to deallocate 2 positions on stack. stack grow from top to bottom as we discussed
      pop ebp           ;make esp point at return address and remove ebp from stack

     ;bring back the registers
     ;poping by the opposite of pushing
      pop edi
      pop esi
      pop ebx

      ret 16             ;it automatically removes all the arguments of the function that were added at the top of stack and uses the return address to jump to it of the next instruction to be executed
                         ;to remove arguments automatically it must be ret 16 ; 16 = number of int arguments * 4

section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'






