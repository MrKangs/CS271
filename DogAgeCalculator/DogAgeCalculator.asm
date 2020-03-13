TITLE Dog years     (demo1.asm)
; Description:  This program gets the age of the user and calculates their age in dog years (age x 7).
INCLUDE Irvine32.inc

.data
age		DWORD	?							; User's age
hi_there	BYTE	"Hi there, this is Ken",0				; Greeting the user
prompt1	BYTE	"Can I have your age please?",0			; Gets age
output		BYTE	"So, your age in dog years is: ",0			; Reposts dog age
byebye		BYTE	"Thanks for passing by, have a great day!",0	; Bye bye
underage	BYTE	"Wow! That young, yet you know how to use a computer!", 0	;Under 5 users will get this statement

.code
main PROC
; Greet the user
	mov	EDX, OFFSET hi_there		; Set up for call to WriteString and greet the user
	call	WriteString
	call	Crlf
; Gets the user's age
	mov	EDX, OFFSET prompt1		; Asks the user's age
	call	WriteString
	call	Crlf
	call	ReadInt			; Reads the users age. Age in EAX
	call	Crlf

; If/Else Statement for age of using computer
	cmp EAX, 5					;Compare the age input and number 5
	JL else1					;If the age is less than 5, then it will go to the else1 instructions
	jmp outofif
else1:							;Else1 instructions 
	mov EDX, OFFSET underage	
	call WriteString
	call Crlf
outofif:


; Calculate the dog years and stores the dog age 
	mov	EBX, 7
	mul	EBX
	mov	age, EAX			; Stores the users dog age. Dog age also in EAX
	
; Reports the dog years and says bye
	mov	EDX, OFFSET output
	call	WriteString
	mov	EAX, age
	call	WriteDec
	call	Crlf
	mov	EDX, OFFSET byebye
	call	WriteString
	call	Crlf
	exit					;exit to operating system
	
main ENDP
END main
