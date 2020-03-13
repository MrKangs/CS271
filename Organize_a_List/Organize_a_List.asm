;This program will change the color of the text (extra credit)
;Then it will take a integer betweem 10 to 200 to generate that many numbers in a list
;Then it will print the unorganize list, the median, and the organize list in rows of 10
;The order of organizing will be large number to small number
;This program is made by Kenneth Kang, March 5th 2020 with help from online and notes in class

INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data

	welcome	BYTE	"	Homework #7: Organize a List		Kenneth Kang.", 0

	instructions_1	BYTE	"Please enter a number between [10, 200] to see all ",0
	instructions_2	BYTE	"of the numbers before and after they're sorted. It will display the median value and show the sorted list in descending order", 0
	instructions_3	BYTE	"Please enter a number between 10 and 200.", 0
	belowError	BYTE	"The number you entered was too small. ", 0
	aboveError	BYTE	"The number you entered was too big. ", 0
	medianString	BYTE	"The median is: ",0
	spaces	BYTE	"   ", 0
	goodbye	BYTE	"Goodbye!", 0
	beforeSort	BYTE	"The array before sorting: ", 0
	afterSort	BYTE	"The array after sorting: ", 0
	number	DWORD  ?
	request	DWORD  ?
	requestTemp	DWORD  ?

	;constants
	MIN				=		 10
	MAX				=		 200
	LO				=		 100
	HI				=		 999
	MAX_SIZE		=		 200

	;Array
	list	DWORD MAX_SIZE DUP(?)  

	;change text color
    extra5  BYTE    "Extra Credit: Color Change. ",0
	colorInt1	DWORD	11
	colorInt2	DWORD	16


.code
 main PROC

    ;Push the color int value into the changeColor function to execute
    push colorInt1
    push colorInt2
    ;Push the statement into the changeColor function to print out that this is extra credit
    push OFFSET extra5
    call changeColor


	call introduction

	push OFFSET request
	call getData

	call Randomize			; seed for generating random numbers

	push OFFSET list
	push request
	call fillArray

	mov  EDX, OFFSET beforeSort
	call WriteString
	call Crlf
	push OFFSET list
	push request
	call displayList

	push OFFSET list
	push request
	call sortList

	call Crlf
	push OFFSET list
	push request
	call displayMedian


	call Crlf
	mov  EDX, OFFSET afterSort
	call WriteString
	call Crlf
	push OFFSET list
	push request
	call displayList

	call farewell

	exit
main ENDP

changeColor PROC

	; Set text color to teal
		push EBP
		mov	 EBP, ESP
        mov EDX, [EBP + 8]   ;extra2 statement
        call WriteString
        mov ECX, 2
		mov  EAX, [EBP + 12] ;colorInt1
		imul EAX, 16
		add  EAX, [EBP + 16] ;colorInt2
		call setTextColor
		pop	 EBP
		ret  12	; Clean up the stack
changeColor	ENDP

introduction PROC

	; Programmer name and title of assignment
	call	 Crlf
	mov		 EDX, OFFSET welcome
	call	 WriteString
	call	 Crlf

	; assignment instructions
	mov		EDX, OFFSET instructions_1
	call	WriteString
	mov		EDX, OFFSET instructions_2
	call	WriteString
	call	Crlf
	ret

introduction ENDP

getData PROC

	; loop to allow user to continue entering numbers until within range of MIN and MAX
		push EBP
		mov	 EBP, ESP
		mov	 EBX, [EBP + 8] ; get address of request into EBX 


	userNumberLoop:
					mov		EDX, OFFSET instructions_3
					call	WriteString
					call	Crlf
					call    ReadInt
					mov     [EBX], EAX		; save the user's request into var request
					cmp		EAX, MIN
					jb		errorBelow
					cmp		EAX, MAX
					jg		errorAbove
					jmp		continue
	;validation

	errorBelow:
					mov		EDX, OFFSET belowError
					call	WriteString
					call	Crlf
					jmp		userNumberLoop
	errorAbove:
					mov		EDX, OFFSET aboveError
					call	WriteString
					call	Crlf
					jmp		userNumberLoop
	continue:
			pop EBP
	ret 4 ; clean up the stack. we only have 1 extra DWORD to get rid of.
getData ENDP

fillArray PROC
	push EBP
	mov  EBP, ESP
	mov  ESI, [EBP + 12]  ; @list
	mov	 ECX, [EBP + 8]   ; loop control based on request

	fillArrLoop:
		mov		EAX, HI
		sub		EAX, LO
		inc		EAX
		call	RandomRange
		add		EAX, LO
		mov		[ESI], EAX  ; put random number in array
		add		ESI, 4		; next element
		loop	fillArrLoop

	pop  EBP
	ret  8
fillArray ENDP

displayList PROC
	push EBP
	mov  EBP, ESP
	mov	 EBX, 0			  ; counting to 10 for ouput
	mov  ESI, [EBP + 12]  ; @list
	mov	 ECX, [EBP + 8]   ; loop control based on request
	displayLoop:
		mov		EAX, [ESI]  ; get current element
		call	WriteDec
		mov		EDX, OFFSET spaces
		call	WriteString
		inc		EBX
		cmp		EBX, MIN
		jl		skipCarry
		call	Crlf
		mov		EBX,0
		skipCarry:
		add		ESI, 4		; next element
		loop	displayLoop
	endDisplayLoop:
		pop		EBP
		ret		8
displayList ENDP

sortList PROC
	push EBP
	mov  EBP, ESP
	mov  ESI, [EBP + 12]			; @list
	mov	 ECX, [EBP + 8]				; loop control based on request
	dec	 ECX
	outerLoop:
		mov		EAX, [ESI]			; get current element
		mov		EDX, ESI
		push	ECX					; save outer loop counter
		innerLoop:
			mov		EBX, [ESI+4]
			mov		EAX, [EDX]
			cmp		EAX, EBX
			jge		skipSwitch
			add		ESI, 4
			push	ESI
			push	EDX
			push	ECX
			call	exchange
			sub		ESI, 4
			skipSwitch:
			add		ESI,4

			loop	innerLoop
			skippit:
		pop		ECX 			; restore outer loop counter
		mov		ESI, EDX		; reset ESI

		add		ESI, 4				; next element
		loop	outerLoop
	endDisplayLoop:
		pop		EBP
		ret		8
sortList ENDP

exchange PROC
	push	EBP
	mov		EBP, ESP
	pushad

	mov		EAX, [EBP + 16]				; address of second number
	mov		EBX, [EBP + 12]				; address of first number
	mov		EDX, EAX
	sub		EDX, EBX					; EDX should now have the difference between the first and second number

	; somehow we got to switch these two up.
	mov		ESI, EBX
	mov		ECX, [EBX]
	mov		EAX, [EAX]
	mov		[ESI], EAX  ; put EAX in array
	add		ESI, EDX
	mov		[ESI], ECX

	popad
	pop		EBP
	ret		12
exchange ENDP

displayMedian PROC
	push EBP
	mov  EBP, ESP
	mov  ESI, [EBP + 12]  ; @list
	mov	 EAX, [EBP + 8]   ; loop control based on request
	mov  EDX, 0
	mov	 EBX, 2
	div	 EBX
	mov	 ECX, EAX


	medianLoop:
		add		ESI, 4
		loop	medianLoop

	; check for zero
	cmp		EDX, 0
	jnz     itsOdd
	; its even
	mov		EAX, [ESI-4]
	add		EAX, [ESI]
	mov		EDX, 0
	mov		EBX, 2
	div		EBX
	mov		EDX, OFFSET medianString
	call	WriteString
	call	WriteDec
	call	Crlf
	jmp		endDisplayMedian

	itsOdd:
	mov		EAX, [ESI]
	mov		EDX, OFFSET medianString
	call	WriteString
	call	WriteDec
	call	Crlf

	endDisplayMedian:

	pop  EBP
	ret  8
displayMedian ENDP

farewell PROC
	; say goodbye

	call	Crlf
	mov		EDX, OFFSET goodbye
	call	WriteString
	call	Crlf
	call	Crlf
	exit
farewell ENDP
END main