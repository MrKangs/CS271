;This Program collect the user name and the user number between 1 to 46 to print out the fibonacci sqeuence 
;Also, this program will be ina different color for extra credit
;This Program was made by Kenneth Kang, 2/16/2020 around 7PM

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

;Data for collecting the user name
	intro1	BYTE	"		Exericse 6:Fibonacci Numbers			by Kenneth Kang",0
	userNameInput	BYTE	"What's your name? ",0
	greating	BYTE	"Hello, ",0
	userName	BYTE	21 DUP(0)
	byteCount DWORD	?
;Data for Beginning of the Fibonacci Sequence	
	intro2	BYTE	"Enter the number of Fibonacci terms to be displayed",0
	intro3	BYTE	"Give the number as an integer in the range [1 .. 46]. ",0
	prompt	BYTE	"How many Fibonacci terms do you want? ",0
	userInt	DWORD	?
	upperLimitInt = 46
	lowerLimitInt = 1
	errorPrompt	BYTE	"Out of range. Enter a number in [1 .. 46]",0	
	spaces	BYTE	"     ",0
	fb1 = 1
	fb2 = 1
	fbNext	DWORD	?
	spacingChecker DWORD 5
;The Extra Credit data: the color sequence that changed
	ECPrompt	BYTE	"The Color of Text and Background have changed",0
	val1	DWORD	29
	val2	DWORD	25
;The End part of the program that is ended
	results	BYTE	"Results certified by Kenneth Kang.",0
	bye	BYTE	"Goodbye, ",0

.code
main proc

		;--------------------------------------------------------------------------------------------------------------------------------------------------------
	Changing_the_Color:
		
		mov EAX, val2						;Moving the val2 statement into EAX

		imul EAX, 16						;Multiplying EAX value with 16 (They are set as 32-bit register value)

		add EAX, val1						;Added the val1 to EAX value

		call setTextColor					;Call the setTextColor to changed the background and the text color

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Introduction:
		mov	EDX, OFFSET intro1				;Moving the intro1 statement into EDX	
		
		call WriteString					;Calling the WriteString function to print out the statement of intro1

		call Crlf							;Clearing the line 

		call Crlf							;Clearing the line 

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Telling_that_the_color_Change:
		
		mov EDX, OFFSET ECPrompt			;Moving the ECpromot to EDX

		call WriteString					;Calling the WriteStrinf function to printout the ECPrompt

		call Crlf							;Clearing the line

		call Crlf							;Clearing the line 

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Get_user_name:
		mov	EDX, OFFSET userNameInput		;Moving the userNameInput statement into EDX	

		call WriteString					;Calling the WriteString function to print out the statement of prompt1

		mov EDX, OFFSET userName			;Moving OFFSET username into EDX
		
		mov ECX, SIZEOF userName			;Moving SIZEOF username into ECX
		
		call ReadString						;Calling the ReadString as the user input a String value (automatically stores in EAX)

		mov byteCount, EAX					;Saving the user name as userName

		call Crlf							;Clearing the line

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Greating_the_User:
		mov EDX, OFFSET greating			;Moving the greating statement to EDX

		call WriteString					;Calling the WriteString function to print out greating statement

		mov EDX, OFFSET userName			;Move the username value into EDX

		call WriteString					;Calling the WriteString function to print out the user name

		call Crlf							;Clearing the line
		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Description_of_the_program:	

		mov EDX, OFFSET intro2				;Moving the intro2 statement into EDX

		call WriteString					;Calling the WriteString function to print out the statement of intro2

		call Crlf							;Clearing the line 

		mov EDX, OFFSET intro3				;Moving the intro2 statement into EDX

		call WriteString					;Calling the WriteString function to print out the statement of intro3

		call Crlf							;Clearing the line 

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Getting_user_int_value:
		
		mov EDX, OFFSET prompt				;Moving the prompt statement into EDX

		call WriteString					;Calling the WriteString function to print out the statement of intro2

		call ReadInt						;Calling the ReadInt as the user input a int value (automatically stores in EAX)

		mov userInt, EAX					;Saving the user input int value as userInt

		call Crlf							;Clearing the line 

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Validating_int_value:

		cmp userInt, upperLimitInt			;Comparing the userInt and the upperLimitInt (userInt > upperLimitInt)

		jg	Errormessage					;If the statement above is true, then go to Errormessage

		cmp userInt, lowerLimitInt			;Comparing the userInt and the lowerLimitInt (userInt < lowerLimitInt)

		jl Errormessage						;If the statement above is true, then go to Errormessage

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	First_two_Fibonacci_Squences:
		
		mov EAX, fb1						;Moving fb1 data to EAX

		call WriteDec						;Calling the WriteDec function to print out fb1

		dec userInt							;Subtract 1 from userInt (the userInt is a counter)

			cmp userInt, 0					;Comparing the userInt and 0 (userInt = 0)	
		
			je End_Message					;If the statement above is true, then go to End_Message

		mov EDX, OFFSET spaces				;Moving spaces value into EDX

		call WriteString					;Calling the WriteString function to space 5 spaces per each term
		
		mov EAX, fb2						;Moving fb2 data into EAX

		call WriteDec						;Calling the WriteDec function to print out fb2

		dec userInt							;Subtract 1 from userInt (the userInt is a counter)
			
			cmp userInt, 0					;Comparing the userInt and 0 (userInt = 0)
		
			je End_Message					;If the statement above is true, then go to End_Message

		;--------------------------------------------------------------------------------------------------------------------------------------------------------
		
	Setting_up_for_the_loop:

		mov EAX, fb1						;Moving fb1 data into EAX

		mov EBX, fb2						;Moving fb2 data into EBX
		
		mov fbNext, fb2						;Moving fb2 data into fbNext (fb1 data will be the same so it doesn't matter)
		
		mov ECX, userInt					;Moving userInt value to ECX (this will be the counter value of the loop)

		mov EDX, OFFSET spaces				;Moving spaces into EDX

		call WriteString					;Calling the WriteString function to print out the spaces between terms

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Fibonacci_Squence_after_three:			;This is the loop of the Fibonacci squence
		
		add EAX, EBX						;Adding EAX and EBX together

		mov EBX, fbNext						;Moving fbNext value to EBX

		mov fbNext, EAX						;Moving EAX value to fbNext

		call WriteDec						;Calling the WriteDec function to print out EAX

		mov EDX, OFFSET spaces				;Moving spaces into EDX

		call WriteString					;Calling the WriteString function to print out the spaces between terms

		cdq									;Need this for the division operator
		
		div spacingChecker					;Dividing EAX with spacingChecker 
		
		cmp EDX, 0							;If EDX is equal to 0 (the remainder of EAX/spacingChecker = 0)

		je Spacing							;Then go to Spacing Function

		mov EAX, fbNext						;If not, move fbNext value to EAX

		loop Fibonacci_Squence_after_three	;Looping back to the beginning of the loop unless ECX = 0 (and the this statement also contains dec ECX)

		jmp End_Message						;If ECX = 0, then go to End_Message

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Spacing:

		call Crlf							;Clearing the line

		mov EAX, fbNext						;moving fbNext value to EAX

		loop Fibonacci_Squence_after_three	;Looping back to the beginning of the loop unless ECX = 0 (and the this statement also contains dec ECX)

		jmp End_Message						;If ECX = 0, then go to End_Message

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	Errormessage:
		
		mov EDX, OFFSET errorPrompt			;Moving errorPrompt to EDX

		call WriteString					;Calling the WriteString function to print out the error message

		call Crlf							;Clearing the line

		jmp  Getting_user_int_value			;Going back to Getting_user_int_value to gain a new int value from the user

		;--------------------------------------------------------------------------------------------------------------------------------------------------------

	End_Message:
		
		call Crlf							;Clearing the line
		
		mov EDX, OFFSET results				;Moving the results statement to EDX

		call WriteString					;Calling the WriteString function to print out results statement

		call Crlf							;Clearing the line

		mov EDX, OFFSET bye					;Moving the bye statement to EDX

		call WriteString					;Calling the WriteString function to print out the bye statement

		mov EDX, OFFSET userName			;Moving the userName data to EDX

		call WriteString					;Calling the WriteString function to print the userName

		call Crlf							;Clearing the line

	invoke ExitProcess,0
main endp
end main
		




