section .data
	str1 db "101",0
	; base1 db 2
	str2 db "0x5",0
	; base2 db 16
	error db "Hi, There's an error here!",10,0
	format db "%d",10,0 ;? Format for the printf call

section .text
	global main
	global ft_atoi_base
	extern ft_strlen
	extern __errno_location
	extern printf
	extern malloc

main:
	; mov rdi, str1
	; mov rsi, 2
	; ; movzx rsi, byte [base1]
	; call ft_atoi_base
	; ;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, str2
	mov rsi, 16
	call ft_atoi_base
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rax, 60
	xor rdi, rdi
	syscall

ft_atoi_base:
	xor rcx, rcx ;* Will hold the number in int format
	xor rbx, rbx ;* Will hold the the char to be converted
	xor rdx, rdx ;* Will be the max possibile character
	mov r8, 1 ;* It will be the sign

ft_atoi_base_loop:
	movzx rbx, byte [rdi]
	test bl, bl
	jz end_loop

	;? Check for the sign of the number to be converted is negative then neg the sign in order to multiply it at the end.
	cmp byte bl, 45
	je change_sign
	back_sign:

	;? Chek for if the character is lowercase and alphabetical if its uppercase make it lowercase if its not character return and error.
	cmp byte bl, 65
	jl check_if_number ;? here if its lower than 65 i need to check if its a normal number
	cmp byte bl, 90
	jle uppercase_character
	back_upper:

	cmp byte bl, 97
	jl not_valid_character
	cmp byte bl, 122
	jg not_valid_character
	back:

	cmp rsi, 10
	jle convert_too_int
	back_convert:
	sub rsi, 10
	add rsi, 97
	add rdx, rsi
	sub rsi, 97
	add rsi, 10

	cmp rbx, rdx
	jg not_valid_character_4
	cmp bl, 48
	jl not_valid_character_2
	cmp bl, 57
	jg not_valid_character_2
	sub bl, 48 ;? Should be in a label
	back_if:
	cmp bl, 97
	jl not_valid_character_3
	cmp bl, 102
	jg not_valid_character_3
	
	cmp bl 
	back_if_else:
	back:
	back_maybe:

	mov rax, rcx      ; Move rcx to rax
	mul rsi           ; Multiply rax by rsi, result in rdx:rax
	mov rcx, rax      ; Move the result back to rcx (lower part of the product)
	; mul rcx, rsi
	movzx rax, bl      ; Move rcx to rax
	mul r8           ; Multiply rax by rsi, result in rdx:rax
	mov bl, al
	; mov bl, rax      ; Move the result back to rcx (lower part of the product)
	; mul bl, r8
	movzx r9, bl      ; Zero-extend bl to 64-bit and move to r8
	add rcx, r9       ; Add r8 to rcx
	; add rcx, bl

	inc rdi
	jmp ft_atoi_base_loop
	movzx rbx, bl
	sub rbx, 48

convert_too_int:
	add rsi, 48
	mov rdx, rsi
	sub rsi, 48
	jmp back_convert

change_sign:
	neg r8
	inc rdi
	jmp back_sign

not_valid_character:
	mov rax, -1
	ret

uppercase_character:
	add bl, 32
	jmp back_upper

end_loop:
	mov rax, rcx
	ret

maybe_char:
	add bl, 58
	sub bl, 97
	jmp back_maybe

check_if_number:
	cmp bl, 48
	jl not_valid_character
	cmp bl, 57
	jg not_valid_character
	jmp back

; TODO:
; 1) Get the sign and the case where the number is negative
; 2) Converta il carattere a minuscolo
; 3) Create a function that would:
;		I) Calculate the last possibile digit that will be representibale.
;		II) Check if the character is number or a character.
;			a) If its a number then just subtract 48 in order to render it a number.
;			b) If its a character then add 10 and then subtract 97 from it to get the character numbericale value ex.(a=10, b=11 ...).
;		III) Something goes wrong return -1.
