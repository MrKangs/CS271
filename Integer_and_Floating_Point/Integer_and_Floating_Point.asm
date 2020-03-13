;This program is take the user name and print it out
;Then the user get an option to choose either int(0) or float(1) to calculate the sum of the 5 numbers and the average of them
;which the user will enter after choosing the option.
;After that, the user will enter 5 numbers and will be store into the stack
;The result will be also in the stack to print out later
;At last, the user will get an option to either redo the whole process or quit the program
;This program is designed by Kenneth Kang, Feb 26th with other friends and TA help

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    ;The title of the program
    into1   BYTE    "		Homework 3:Integer_and_Floating_Point			by Kenneth Kang",0

    ;Extra credit. Description in the data
    extra1  BYTE    "Extra Credit: Pushes strings into stack in the introduction and then prints them out and prints out the Float Stack", 0
    extra2  BYTE    "Extra Credit: Color Change. ",0
    
    ;I hope you count this as extra credit even though I saved the value in a veruable 
    colorInt1   DWORD   13
    colorInt2   DWORD   15
    
    ;User name input with asking the question of the user name
    userNameInput BYTE    "Please Enter your Name: ", 0
    output  BYTE "Hello, ", 0
    userName   BYTE    21 DUP(0)

    ;Asking the user whether to do int calculation or floating point calculation
    question BYTE    ". Do you want to perform integer or floating-point arithmetic? ",0
    option1 BYTE    "Please type 0 for integer or 1 for floating point arithmetic: ",0

    ;Once the user choose an option, it will give the following statements
    floatSelection BYTE    "You choose to perform floating point arithmetic.", 0
    intSelection BYTE    "You choose to perform integer arithmetic.", 0

    ;Asking the user to enter 5 numbers
    inputNum BYTE    "Please enter 5 numbers",0

    ;The sum, average, and remainder result statement without the value
    sumResult BYTE    "The sum of the numbers you enter is: ",0
    averageResult BYTE    "The average of the numbers is:",0
    remainderResult BYTE    " Remainder:", 0

    ;Asking the user to redo the program again or not
    option2 BYTE    "Do you want to perform another calculation? Please enter 0 for no or 1 for yes", 0
    
    ;If the user choose not to do, then the user will get an message
    bye BYTE    "Bye! Have a nice day!",0

.code
main proc
    ;Push the color int value into the changeColor function to execute
    push colorInt1
    push colorInt2
    ;Push the statement into the changeColor function to print out that this is extra credit
    push OFFSET extra2
    call changeColor

    ;Push the statements of introduction, extra credit, and userName into the Introduction function
    push OFFSET into1
    push OFFSET extra1
    push OFFSET userNameInput
    push OFFSET userName
    push SIZEOF userName
    push OFFSET output
    call Introduction
    pop EBP
    ret 60

    ;calls the User_Instruction: this contains the user input for number, calculation, and printing out the results 
    call User_Instruction
    pop EBP
    ret 16

main endp

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

Introduction proc ;Prints out the intro
    push EBP
    mov EBP, ESP
    call Crlf
    mov EDX, [EBP + 28] ;into1
    call WriteString
    call Crlf
    mov EDX, [EBP + 24] ;extra1
    call WriteString
    call Crlf
    mov EDX, [EBP + 20] ;userNameInput
    call WriteString
    mov EDX, [EBP + 16] ;username OFFSET
    mov ECX, [EBP + 12] ;username SIZEOF
    call ReadString
    mov EDX, [EBP + 8]  ;output
    call WriteString
    mov EDX, [EBP + 16]
    call WriteString

Introduction ENDP

User_Instruction proc ;Asks user for integer or float
    push OFFSET question
    push OFFSET option1
    push OFFSET floatSelection
    push OFFSET intSelection
    push OFFSET inputNum

    push EBP
    mov EBP, ESP
    mov EDX, [EBP + 20] ;Question
    call WriteString
    call Crlf
    mov EDX, [EBP + 16] ;Option1
    call WriteString
    call ReadDec
    cmp EAX, 1
    je float
    mov EDX, [EBP + 8] ;int stack, jmps to int stack calculations ;intselection
    call WriteString
    call Crlf
    mov EDX, [EBP + 4]  ;inputNum
    call WriteString
    call Crlf
    jmp IntData ;Jumps to IntData which contains the user input for the 5 numbers, total sum, and average
    pop EBP
    ret 60

    float: ;float stack, jmps to float stack calculations
        mov EDX, [EBP + 12] ;floatselection
        call WriteString
        call Crlf
        mov EDX, [EBP + 4]  ;inputNum
        call WriteString
        call Crlf
        jmp FloatData   ;Jumps to FloatData which contains the user input for the 5 numbers, total sum, and average

    outofit:

User_Instruction endp

IntData proc ;Integer stack
    mov ECX, 5
    push EBP
    mov EBP, ESP
    Get_Data: ;Gets the numbers and puts it onto the stack
        call ReadInt
        push EAX
        loop Get_Data

    Calculate_Sum: ;Finds the sum and the average of the stack

        mov EAX, [ESP + 16] ;first int
        add EAX, [ESP + 12] ; + second int
        add EAX, [ESP + 8]  ; + thrid int
        add EAX, [ESP + 4]  ; + fourth int
        add EAX, [ESP]  ; + fifth int = total sum
        mov EDX, OFFSET sumResult   ;Print the sumResult Statement
        call WriteString
        call WriteDec   ;Print the sum of ints 
        call Crlf
        mov EDX, OFFSET averageResult   ;Print the averageResult statement
        call WriteString
        cdq
        mov EBX, 5  ;Since there is only five numbers, move the value 5 to EBX
        div EBX ;Divide the EAX result of EBX
        mov ECX, EDX
        call WriteDec  ;Print the average value
        mov EDX, OFFSET remainderResult
        call WriteString
        mov EAX, ECX
        call WriteDec   ;Print the remainder
        jmp Good_bye    ;Jumps to Good_bye function

IntData endp

FloatData proc ;Float stack
    mov ECX, 5
    push EBP
    mov EBP, ESP
    FINIT
    Get_Data1: ;Reads in the numbers and pushes them onto the stack
        call ReadFloat
        loop Get_Data1

    Calc_Sum1: ;Finds the sum and the average
        call ShowFPUStack
        mov  EAX, [ESP + 16]    ;float1
        fadd st, st(1)  ; + float2
        fadd st, st(2)  ; + float3
        fadd st, st(3)  ; + float4
        fadd st, st(4) ; + float5 = total sum

    mov EDX, OFFSET sumResult   ;Print the sumResult Statement
    call WriteString
    call WriteFloat
    call Crlf
    mov EDX, OFFSET averageResult   ;Print the averageResult Statement
    call WriteString
    push 5
    FILD DWORD ptr[esp]
    FDIV ;average
    call WriteFloat
    jmp Good_bye
FloatData endp

Good_bye proc ;Asks the user if they want to loop or exits out and says bye
    call Crlf
    mov EDX, OFFSET option2
    call WriteString
    call Crlf
    call ReadInt
    cmp EAX, 1
    je User_Instruction
    ;displays a bye message
    mov EDX, OFFSET bye
    call WriteString
    call Crlf
Good_bye endp
invoke ExitProcess,0

end main