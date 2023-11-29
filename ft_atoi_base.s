section .data
	str1 db "101",0 ;base 2 => 5
	str2 db "0x5",0 ;base 16 => 5
	str3 db "100",0 ;base 10
	str4 db "21",0 ;base 7 => 15
	str5 db "-21",0 ;base 10
	str6 db "-1B0",0 ;base 16 => -432
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
	mov rdi, str1
	mov rsi, 2
	; movzx rsi, byte [base1]
	call ft_atoi_base
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str2
	mov rsi, 16
	call ft_atoi_base
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str3
	mov rsi, 10
	call ft_atoi_base
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str4
	mov rsi, 7
	call ft_atoi_base
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str5
	mov rsi, 10
	call ft_atoi_base
	;* printf rax
	mov rsi, rax
	mov rdi, format
	xor rax, rax
	call printf wrt ..plt

	mov rdi, str6
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
	movzx r10, byte [rdi]
	cmp rsi, 16
	je handle_0x
	what:

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

	;* c <= max_digit
	cmp rbx, rdx
	jg not_valid_char_4

	;* c >= '0' && c <= '9'
	cmp bl, 48
	jge further_check
	back_from_further_check:

	;* c >= 'a' && c <= 'f'
	cmp bl, 97
	jge further_check_char

	done: ;* To get back from the further_check

	mov rax, rcx      ; Move rcx to rax
	mul rsi           ; Multiply rax by rsi, result in rdx:rax
	mov rcx, rax      ; Move the result back to rcx (lower part of the product)

	movzx rax, bl      ; Move rcx to rax
	mul r8           ; Multiply rax by rsi, result in rdx:rax
	mov bl, al
	movsx r9, bl      ; Zero-extend bl to 64-bit and move to r8
	add rcx, r9       ; Add r8 to rcx
	; add rcx, bl

	inc rdi
	jmp ft_atoi_base_loop
	; movzx rbx, bl
	; sub rbx, 48

convert_too_int:
	add rsi, 48
	mov rdx, rsi
	sub rsi, 48
	jmp back_convert

change_sign: ;* You can add anotehr condition to have if a sign is inside the string
	neg r8
	inc rdi
	movzx rbx, byte [rdi]
	jmp back_sign

not_valid_character:
	mov rax, -1
	ret

uppercase_character:
	add bl, 32
	jmp back_upper

end_loop: ;* You will need to mul with the sign
	mov rax, rcx
	ret

maybe_char: ;* 10 + c - 'a'
	add bl, 10
	sub bl, 97
	jmp done

check_if_number:
	cmp bl, 48
	jl not_valid_character
	cmp bl, 57
	jg not_valid_character
	jmp back

not_valid_char_4:
	mov rax, -1
	ret

further_check:
	cmp bl, 57
	jg back_from_further_check
	sub bl, 48 
	jmp done

further_check_char:
	cmp bl, 102
	jg not_valid_char_4
	jmp maybe_char

handle_0x:
	cmp r10, 48
	je inco_1
	back_1:
	cmp r10, 120
	je inco_2
	back_2:
	cmp r10, 88
	je inco_3
	back_3:
	jmp what

inco_1:
	inc rdi
	movzx r10, byte [rdi]
	jmp back_1

inco_2:
	inc rdi
	movzx r10, byte [rdi]
	jmp back_2

inco_3:
	inc rdi
	movzx r10, byte [rdi]
	jmp back_3


; TODO:
; 1) Get the sign and the case where the number is negative
; 2) Converta il carattere a minuscolo
; 3) Create a function that would:
;		I) Calculate the last possibile digit that will be representibale.
;		II) Check if the character is number or a character.
;			a) If its a number then just subtract 48 in order to render it a number.
;			b) If its a character then add 10 and then subtract 97 from it to get the character numbericale value ex.(a=10, b=11 ...).
;		III) Something goes wrong return -1.
; TODO for the error managment:
; 1) If base is empty or 1
; 2) If str is empty
; 3) Check for base - or +
; 4) Do the same check for the num
; TODO:
; 1) first check if either is empty
; 2) while looping through the base base sure there are no signs
; 3) for the num loop the white spaces signs and obtain the right sign
; 4) concatinate the string at the last valid char
