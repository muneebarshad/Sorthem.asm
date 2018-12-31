;;;;;;;;;;;;;;;;Muneeb Arshad 400135910 arsham14 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



%include "asm_io.inc" 
extern rconf
extern printf
extern getchar

SECTION .data


error1: db "Incorrect number of arguments",10,0
error2: db "Argument not in range",10,0
initial: db "initial configuration",10,0
final: db "final configuration",10,0
t1: db   "        o|o          ",0
t2: db   "       oo|oo         ",0
t3: db   "      ooo|ooo        ",0
t4: db   "     oooo|oooo       ",0
t5: db   "    ooooo|ooooo      ",0
t6: db   "   oooooo|oooooo     ",0
t7: db   "  ooooooo|ooooooo    ",0
t8: db   " oooooooo|oooooooo   ",0
t9: db   "ooooooooo|ooooooooo  ",0
base: db "XXXXXXXXXXXXXXXXXXXXXXX",0
array: dd 0,0,0,0,0,0,0,0,0,0
NumOfDisk: dd 0
NumofDisk: dd 0
test: db "testing",10,0
counter: dd 0
counter2: dd 0
tmp: dd 0
waits: db "waiting to enter",10,0
SECTION .bss
numofdisks: resd 1
tmp2: resd 1


SECTION .text
	global asm_main
	
printBase:
	enter 0,0
	push base
	call printf
	
	leave
	ret

sorthem:
	   enter 0,0 
    pusha
    mov edx, [ebp+8]  
    mov ecx, [ebp+12] ; ecx stores address of array
    cmp edx, dword 0
    je loop1       ; base case when disks = 1
       
    add ecx, 4
    push ecx
    dec edx
    push edx
    call sorthem
  ;  add ecx, 4
 ;   dec edx
    add esp, 8
    ;;;;;;;;;;;;;;;;;;;;;;;
    jmp loop2

        loop1:
                popa
                leave
                ret

        loop2:
                ;ecx points to prev
                sub ecx, 4
               
                mov ebx, edx 

        sorting:
            cmp ebx, 0
            je end_sort
            mov eax, [ecx]  ; move current disk into eax
            cmp eax, dword [ecx+4] ; compare with next disk
            dec ebx
            jbe sorting
            mov [tmp2], eax   ; temp holds current
            mov eax, [ecx+4]  ; eax holds next
            mov [ecx], eax
            mov eax, [tmp2]
            mov [ecx+4], eax  ; now next = current disk
            add ecx, 4
            jmp sorting

        end_sort:
           push array
           push dword [numofdisks]
           call showp
	   call print_nl
           add esp, 8
	   jmp finish
		
		finish:
                popa
                leave
                ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printDisks:
  enter 0,0               ; setup routine

  
  new_t0:
    cmp eax, 0        
    jnz new_t1             
    jmp end            
  ;;;;;;;;;;;;
  new_t1:
    cmp eax, 1       
    jne new_t2          
    push t1             
    jmp end             
  ;;;;;;;;;;;
  new_t2:
    cmp eax, 2          
    jne new_t3          
    push t2             
    jmp end      
 ;;;;;;;;;;;;;;;;;
  new_t3:
    cmp eax, 3           
    jne new_t4            
    push t3               
    jmp end               
 ;;;;;;;;;;;;;;;;;
  new_t4:
    cmp eax, 4            
    jne new_t5            
    push t4               
    jmp end               
 ;;;;;;;;;;;;;;
  new_t5:
    cmp eax, 5            
    jne new_t6            
    push t5               
    jmp end               
  ;;;;;;;;;;;;
  new_t6:
    cmp eax, 6        
    jne new_t7        
    push t6           
    jmp end         
  ;;;;;;;;;;;;;
  new_t7:
    cmp eax, 7      
    jne new_t8      
    push t7         
    jmp end         
  ;;;;;;;;;;;
  new_t8:
    cmp eax, 8      
    jne new_t9      
    push t8         
    jmp end          
  ;;;;;;;;;;;
  new_t9:
    push t9          
;;;;;;;;;;;;;
  end:
    call printf 
    call print_nl
    leave   
    ret 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  showp:
	enter 0,0
	pusha
		
	Reset:
		mov ebx, 0
	SHOW:
	
	
	mov eax,dword[array + ebx]
;	call print_int

	
        cmp eax, dword 0
        je end_showp         ;print int
        call printDisks
        add ebx, 4
        jmp SHOW
	

   	end_showp:
	call printBase
	call print_nl
	popa
	leave
	ret	
  
           ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

asm_main:
	enter 0,0	;setup routine
	pusha		;save all registers

	mov ecx, dword[ebp+8] ;argc
	cmp ecx, dword 2
	jne err1           ;if number of arguments not equal to 1 then jump to err1
	
	mov ebx, [ebp+12]	
	mov ecx, [ebx+4]	;ecx point to the first(main) argument 
	
	mov al, byte [ecx]	;1st byte of argument stored in al	
	
	
	cmp al, 39h
	ja err2
	cmp al, 32h
	jb err2
	
	sub al, 48	;convert in integer
;	mov [NumOfDisk], al
	mov [numofdisks], al
	mov edx, dword[numofdisks]	;edx stores number of disk
;	call print_int
	mov eax, array			;eax stores pointer to the array
	push edx		;push number of disk
	push eax		;push empty array
	call rconf
	
;	mov edx, [NumofDisk]
;	call print_int
;	call print_nl
			;cal functio
	add esp,8			;adjust stack pointe
	inc edx
	mov eax,initial
	call print_string
	call showp
	add esp,8	
	call print_nl
	mov eax, waits
	call print_string
	call read_char
	mov ecx,[numofdisks]
	mov eax, array
	push eax
	push ecx
	call sorthem
;	add esp, 8
	call print_nl
	mov eax, final
	call print_string
	call print_nl
	call showp

	
	        
	jmp asm_main_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	err1:
		mov eax,error1
		call print_string
		jmp asm_main_end
	err2:
		mov eax, error2
		call print_string
		jmp asm_main_end

	asm_main_end:
 		popa
		leave
		ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END of PROGRAM;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
