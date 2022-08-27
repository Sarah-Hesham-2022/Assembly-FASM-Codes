format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable      ;basic imports to get our console running

start:                                ;here start coding

mov eax,[arr]         ;make eax point to address of the array, to loop
mov [min],eax         ;copy address of eax to address of min variable to loop ,I did this because it is prohibited to deal with 2 memory addresses at the same time, so use a register as an intermediate consultor
                      ;now we have the first element of the array at min

L1:  mov esi,[i]      ;initialize esi with index of 0 ,to loop
     cmp esi,[size]    ;compare esi that carries the current index with the total array size
     je L2             ;jump if equal to each other esi=size to label L2
     mov ecx,[arr+4*esi] ;else let register ecx point to second element in array after the current one being pointed at, since our array is size dd=4 bytes so we increment with 4*esi as array elements are stored sequential each of same data size and esi carries current element address
     cmp ecx,[min]       ;compare value of ecx which is current pointed to array element and value in min
     jge L3              ;if current value pointed to is greater than min, jump to a label called L3
     mov [min],ecx       ;else, this means min is greater ,so replace min with the value of the smaller element

L3:                      ;label L3 we go to it when ecx > min, so we needn't do a lot
  inc [i]                ;just increment i to move to another element
  jmp L1                 ;jump back to label L1, to do the comparison all over again

L2:                     ;label L2 we go to it when esi==size, which means we reach end of our array
   cinvoke printf, f1,[min]  ;so in this case we just print our min value
   cinvoke scanf, f2, x      ;let us take any number from user just to keep console on running to see our min
exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable

f1 db 'Minimum Element is  =  %d',0    ;string to print
f2 db '%d',0                           ;string to print
x dd ?                                 ;number to take from user, unknown value till now
arr dd 1,2,3,-4,5                      ;my array creation
size  dd 5                             ;size of my array
min dd 10000                           ;a random value to make logic
i dd 0                                 ;our starting index to loop over the array

section '.idata' import data readable writeable               ;basic imports
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'






