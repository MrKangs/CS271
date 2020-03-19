
INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

mPowerSquare MACRO param1
	push eax
	push edi
	mov edi, OFFSET param1
	mov eax, [edi]
	mul eax
	mov [edi], eax
	pop edi
	pop eax
ENDM

mWriteDec	MACRO	param1
	push eax
	mov eax, param1
	call WriteDec
	call Crlf
	pop eax
ENDM

.data	
x	DWORD	 15
y	DWORD	 11
z	DWORD	 25
					
.code					
main PROC				
	push x					
	push y					
	push OFFSET z					
	call whatzit					
	mPowerSquare x					
	mPowerSquare y		
	mWriteDec x
	mWriteDec y			
	exit					
main ENDP					

whatzit PROC					
	push ebp					
	mov ebp, esp					
	mov edi, [ebp+8]					
	mov eax, [ebp+16]					
	mov ebx, eax					
	sub ebx, [ebp+12]					
	mul ebx					
	mov [edi], eax					
	pop ebp					
	ret 12					
whatzit ENDP					
END main