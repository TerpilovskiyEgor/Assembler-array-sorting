include mcr.asm

DATA_S segment
	Text_MassSum db "Sum: ", '$'
	Text_Max db "Max: ", '$'
	Text_Min db "Min: ", '$'
	Text_Coordinates db "Coordinates: ", '$'
	Text_SortedArray db "Sorted array: ", '$'
	
	Mass dw 11, 9, 19, 4, 7, 0, -9, 52, -5
DATA_S ends

STACK_S segment STACK
	db 512 dup(?) 
STACK_S ends

ASSUME CS:CODE, DS:DATA_S, SS:STACK_S

CODE segment
	mov AX, DATA_S
	mov DS, AX
	
	PrintText Text_MassSum
	MassSum Mass
	PrintChar 10
	
	PrintText Text_Max
	GetMax Mass
	PrintChar 10
	
	PrintText Text_Min
	GetMin Mass
	PrintChar 10
	
	PrintText Text_Coordinates
	GetCoordinates Mass, 19
	PrintChar 10
	
	PrintText Text_SortedArray
	Sorting Mass
	PrintChar 10
	
	ENDProg
CODE ends
end