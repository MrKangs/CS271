;This program will take two integers from the user input 
;and do basic math operators such as addition, subtraction, multiplication, and division with the results of remainder
;This program was made by Kenneth Kang at Feb 16th , 7PM

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096	;SS
ExitProcess proto,dwExitCode:dword

.data
	intro1	BYTE	"		Exericse 5:Elementary Arithmetic			by Kenneth Kang",0
	intro2	BYTE	"Enter 2 positive integer numbers, and I'll show you the sum, difference, product, quotient, and remainder.",0
	prompt1 BYTE	"Please give me your first number:",0
	prompt2 BYTE	"Please give me your second number:",0
	int1	DWORD	?
	int2	DWORD	?
	addition	DWORD	?
	subtraction	DWORD	?
	multiplication DWORD	?
	division	DWORD	?
	remainder	DWORD	?
	add_sign	BYTE	" + ",0
	sub_sign	BYTE	" - ",0
	mul_sign	BYTE	" * ",0
	div_sign	BYTE	" / ",0
	mod_sign	BYTE	" remainder ",0
	equal_sign	BYTE	" = ",0
	bye1	BYTE	"Thank you for using this calculator! Have a nice day!",0

.code
main proc

	Introduction:
		mov	EDX, OFFSET intro1			;Moving the into1 statement into EDX	
		
		call WriteString				;Calling the WriteString function to print out the statement of intro1

		call Crlf						;Clearing the line 

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Description_of_the_program:	
		mov EDX, OFFSET intro2			;Moving the into2 statement into EDX

		call WriteString				;Calling the WriteString function to print out the statement of intro2

		call Crlf						;Clearing the line 

		call Crlf						;Clearing the line 

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Get_first_int:
		mov	EDX, OFFSET prompt1			;Moving the prompt1 statement into EDX	

		call WriteString				;Calling the WriteString function to print out the statement of prompt1

		call ReadInt					;Calling the ReadInt as the user input a int value (automatically stores in EAX)

		mov int1, EAX					;Saving the user input int value as int1

		call Crlf						;Clearing the line

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Get_second_int:
		mov	EDX, OFFSET prompt2			;Moving the prompt2 statement into EDX	
		
		call WriteString				;Calling the WriteString function to print out the statement of prompt1

		call ReadInt					;Calling the ReadInt as the user input a int value (automatically stores in EAX)

		mov int2, EAX					;Saving the user input int value as int1

		call Crlf						;Clearing the line

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Calculations:

		;Addition

		mov EAX, int1					;Moving int1 data into EAX

		add	EAX, int2					;Adding two integers

		mov addition, EAX				;Saving the results in the value called addition

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

		;Subtraction

		mov EAX, int1					;Resetting the EAX value into int1

		sub EAX, int2					;Subtracting two integers

		mov subtraction, EAX			;Saving the results in the value called subtraction

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

		;Multiplication

		mov EAX, int1					;Resetting the EAX value into int1

		mul int2						;Multiplication two integers

		mov multiplication, EAX			;Saving the results in the value called multiplication

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

		;Division & Remainder

		mov EAX, int1					;Resetting the EAX value into int1

		div int2						;Dividing two numbers

		mov division, EAX				;Saving the division results in the value called division

		mov remainder, EDX				;Saving the remainder results in the value called remainder

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Report_calculations:

		;--------------------------------------------------------------------------------------------------------------------------------------------------------
	
		;Addition Calculation Report
		mov	EAX, int1					;Moving int1 value into EAX

		call WriteDec					;Calling the Writing number function to print int1

		mov	EDX, OFFSET add_sign		;Moving add_sign value into EDX		

		call WriteString				;Calling the WriteString function to print out the add_sign

		mov	EAX, int2					;Moving int2 value into EAX

		call WriteDec					;Calling the Writing number function to print int2

		mov EDX, OFFSET equal_sign		;Moving equal_sign value into EDX	

		call WriteString				;Calling the WriteString function to print out the equal_sign

		mov	EAX, addition				;Moving the addition value into EAX

		call WriteDec					;Calling the Writing number function to print addition results

		call Crlf						;Clearing the line

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

		;Subtraction Calculation Report
		mov	EAX, int1					;Moving int1 value into EAX

		call WriteDec					;Calling the Writing number function to print int1

		mov	EDX, OFFSET sub_sign		;Moving sub_sign value into EDX		

		call WriteString				;Calling the WriteString function to print out the sub_sign

		mov	EAX, int2					;Moving int2 value into EAX			

		call WriteDec					;Calling the Writing number function to print int2

		mov EDX, OFFSET equal_sign		;Moving equal_sign value into EDX

		call WriteString				;Calling the WriteString function to print out the equal_sign

		mov	EAX, subtraction			;Moving the subtraction value into EAX

		call WriteDec					;Calling the Writing number function to print subtraction results

		call Crlf						;Clearing the line

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

		;Multiplication Calculation Report
		mov	EAX, int1					;Moving int1 value into EAX	

		call WriteDec					;Calling the Writing number function to print int1

		mov	EDX, OFFSET mul_sign		;;Moving mul_sign value into EDX	

		call WriteString				;Calling the WriteString function to print out the mul_sign

		mov	EAX, int2					;Moving int2 value into EAX

		call WriteDec					;Calling the Writing number function to print int2

		mov EDX, OFFSET equal_sign		;Moving equal_sign value into EDX

		call WriteString				;Calling the WriteString function to print out the equal_sign

		mov	EAX, multiplication			;Moving the mulitiplication value into EAX

		call WriteDec					;Calling the Writing number function to print multiplication result

		call Crlf						;Clearing the line

		;--------------------------------------------------------------------------------------------------------------------------------------------------------
		
		;Division and Remainder Calculation Report
		mov	EAX, int1					;Moving int1 value into EAX	

		call WriteDec					;Calling the Writing number function to print int1

		mov	EDX, OFFSET div_sign		;Moving div_sign value into EDX	

		call WriteString				;Calling the WriteString function to print out the div_sign

		mov	EAX, int2					;Moving int2 value into EAX

		call WriteDec					;Calling the Writing number function to print int2

		mov EDX, OFFSET equal_sign		;Moving equal_sign value into EDX

		call WriteString				;Calling the WriteString function to print out the equal_sign

		mov	EAX, division				;Moving the division value into EAX

		call WriteDec					;Calling the Writing number function to print division results

		mov EDX, OFFSET mod_sign		;;Moving mod_sign value into EDX

		call WriteString				;Calling the WriteString function to print out the mod_sign

		mov EAX, remainder				;Moving the remainder value into EAX

		call WriteDec					;Calling the Writing number function to print remainder results

		call Crlf						;Clearing the line

		call Crlf						;Clearing the line

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Good_bye:
		mov	EDX, OFFSET bye1			;Moving bye1 value into EDX	

		call WriteString				;Calling the WriteString function to print bye1 results 

		call Crlf						;Clearing the line



	invoke ExitProcess,0
main endp
end main