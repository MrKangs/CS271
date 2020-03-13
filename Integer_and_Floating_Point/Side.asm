INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

    into1   BYTE    "		Homework 3:Integer_and_Floating_Point			by Kenneth Kang",0

    extra1  BYTE    "Extra Credit: Pushes strings into stack in the introduction and then prints them out and prints out the Float Stack", 0
    extra2  BYTE    "Extra Credit: Color Change",0

    userNameInput BYTE    "Please Enter your Name", 0
    output  BYTE "Hello, ", 0
    userName   BYTE    21 DUP(0)

    option1 BYTE    "Do you want to perform integer or floating-point arithmetic? Please type 0 for integer or 1 for floating point arithmetic.",0

    floatSelction BYTE    "You choose to perform floating point arithmetic.", 0
    intSelction BYTE    "You choose to perform integer arithmetic.", 0
    inputNum BYTE    "Please enter 5 numbers",0

    sumResult BYTE    "The sum of the numbers you enter is: ",0
    averageResult BYTE    "The average of the numbers is:",0
    remainderResult BYTE    " Remainder:", 0

    option2 BYTE    "Do you want to perform another calculation? Please enter 0 for no or 1 for yes", 0
    bye BYTE    "Bye! Have a nice day!",0

.code
main proc
    ;pushes the strings onto the stack
    push OFFSET into1
    push OFFSET extra
    push OFFSET userNameInput
    push OFFSET userName
    push SIZEOF userName
    push OFFSET output
    call Introduction
    pop EBP
    ret 60

    ;calls the User_Instruction
    call User_Instruction
    pop EBP
    ret 16

main endp

Introduction proc ;Prints out the intro
    push EBP
    mov EBP, ESP
    mov EDX, [EBP + 24]
    call WriteString
    call Crlf
    mov EDX, [EBP + 20]
    call WriteString
    call Crlf
    mov EDX, [EBP + 16]
    mov ECX, [EBP + 12]
    call ReadString
    mov EDX, [EBP + 8]
    call WriteString
    mov EDX, [EBP + 16]
    call WriteString

Introduction ENDP

User_Instruction proc ;Asks user for integer or float
    push OFFSET option1
    push OFFSET floatSelection
    push OFFSET intSelection
    push OFFSET inputNum

    push EBP
    mov EBP, ESP
    mov EDX, [EBP + 16]
    call WriteString
    call ReadDec
    cmp EAX, 1
    je else1
    mov EDX, [EBP + 8] ;int stack, jmps to int stack calculations
    call WriteString
    call Crlf
    mov EDX, [EBP + 4]
    call WriteString
    call Crlf
    jmp Data
    pop EBP
    ret 60

    else1: ;float stack, jmps to float stack calculations
        mov EDX, [EBP + 12]
        call WriteString
        call Crlf
        mov EDX, [EBP + 4]
        call WriteString
        call Crlf
        jmp AData

    outofit:

User_Instruction endp

Data proc ;Integer stack
    mov ECX, 5
    push EBP
    mov EBP, ESP
    Get_Data: ;Gets the numbers and puts it onto the stack
        call ReadInt
        push EAX
        loop Get_Data

    Calculate_Sum: ;Finds the sum and the average of the stack

        mov EAX, [ESP + 16]
        add EAX, [ESP + 12]
        add EAX, [ESP + 8]
        add EAX, [ESP + 4]
        add EAX, [ESP]
        mov EDX, OFFSET sumResult
        call WriteString
        call WriteDec
        call Crlf
        mov EDX, OFFSET averageResult
        call WriteString
        cdq
        mov EBX, 5
        div EBX
        mov ECX, EDX
        call WriteDec
        mov EDX, OFFSET remainderResult
        call WriteString
        mov EAX, ECX
        call WriteDec
        jmp Good_bye

Data endp

AData proc ;Float stack
    mov ECX, 5
    push EBP
    mov EBP, ESP
    FINIT
    Get_Data1: ;Reads in the numbers and pushes them onto the stack
        call ReadFloat
        loop Get_Data1

    Calc_Sum1: ;Finds the sum and the average
        call ShowFPUStack
        mov  EAX, [ESP + 16]
        fadd st, st(1)
        fadd st, st(2)
        fadd st, st(3)
        fadd st, st(4) ;sum

    mov EDX, OFFSET sumResult
    call WriteString
    call WriteFloat
    call Crlf
    mov EDX, OFFSET averageResult
    call WriteString
    push 5
    FILD DWORD ptr[esp]
    FDIV ;average
    call WriteFloat
    jmp Good_bye
AData endp

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