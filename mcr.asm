PrintChar macro Char
	push AX
	push DX
	
	mov AH,02h
	mov DL,Char
	int 21h
	
	pop DX
	pop AX
endm

PrintNum macro Char
	push AX
	push DX
	
	mov DL,Char
	add DL,48
	mov AH,02h
	int 21h
	
	pop DX
	pop AX
endm

PrintText macro Text
	push AX
	push DX
	
	mov AH,09h
	mov DX, offset Text
	int 21h
	
	pop DX
	pop AX
endm

PrintNumber macro Number
local Label_NotNegative, Cycle_Label, Loop_Label
push AX
push BX
push CX
push DX
	mov AX,Number
	
	cmp AX,0
	jge Label_NotNegative
		PrintChar '-'
		neg AX
	Label_NotNegative:
	
	xor CX,CX
	mov BX,10
	Cycle_Label:
		xor DX,DX
		div BX
		add DX,48d
		push DX
		inc CX
		cmp AX,0
	jne Cycle_Label
	
	mov AH,02h
	Loop_Label:
		pop DX
		int 21h
	loop Loop_Label
pop DX
pop CX
pop BX
pop AX
endm

ENDProg macro
	mov AH,02h
	mov DL,10
	int 21h

	mov AH, 10h
	int 16h

	mov AX, 4C00h
	int 21h
endm

MassSum macro Mass
local Loop_Label
	mov SI, offset Mass
	mov AX,0000
	mov CX,9
	Loop_Label:
		add AX,[SI]
		add SI,2
	loop Loop_Label
	PrintNumber AX
endm

GetMax macro Mass
local Loop_Label, Label_AXLarger
	mov SI, offset Mass
	mov AX,[SI]
	mov CX,8
	Loop_Label:
		add SI,2
		cmp AX,[SI]
		jge Label_AXLarger
			mov AX,[SI]
		Label_AXLarger:
	loop Loop_Label
	PrintNumber AX
endm

GetMin macro Mass
local Loop_Label, Label_AXLess
	mov SI, offset Mass
	mov AX,[SI]
	mov CX,8
	Loop_Label:
		add SI,2
		cmp AX,[SI]
		jle Label_AXLess
			mov AX,[SI]
		Label_AXLess:
	loop Loop_Label
	PrintNumber AX
endm

GetCoordinates macro Mass, Num
local Loop_Label, Label_NotEqual
	mov SI, offset Mass
	mov BX,3
	mov CX,9
	xor AX,AX
	Loop_Label:

		cmp [SI],Num
		jne Label_NotEqual
			push AX
			div BL
			PrintChar '['
			PrintNum AL
			PrintChar ';'
			PrintNum AH
			PrintChar ']'
			xor AX,AX
			pop AX
		Label_NotEqual:
		add SI,2
		inc AX
	loop Loop_Label
endm

Sorting macro Mass
local Loop_Label_1, Loop_Label_2, Label_1
	mov SI, offset Mass
	mov DI,offset Mass
	add DI,16
	mov CX,9
	Loop_Label_1:
		cmp SI,DI
		je Label_1
			mov AX,[SI]
			mov BX,[SI+2]
			cmp AX,BX
			jle Label_2
				mov [SI+2],AX
				mov [SI],BX
				mov CX,9
				mov SI, offset Mass
				jmp Loop_Label_1
			Label_2:
		add SI,2
	loop Loop_Label_1
	Label_1:
	
	mov SI, offset Mass
	mov CX,9
	Loop_Label_2:
		mov AX,[SI]
		PrintNumber AX
		PrintChar ' '
		add SI,2
	loop Loop_Label_2
endm
