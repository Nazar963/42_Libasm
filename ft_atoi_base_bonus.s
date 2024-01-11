section .data
	;* Valid inputs
	str1 db "101",0 ;base 2 => 5
	str11 db "2",0
	str2 db "0x5",0 ;base 16 => 5
	str22 db "16",0
	str3 db "100",0 ;base 10
	str33 db "10",0
	str4 db "21",0 ;base 7 => 15
	str44 db "7",0
	str5 db "-21",0 ;base 10
	str55 db "10",0
	str6 db "-1B0",0 ;base 16 => -432
	str66 db "16",0
	str7 db "   ---+--+1234ab567",0 ;base 16 => -432
	str77 db "10",0
	;* inputs with errors in the base
	; str1 db "101",0 ;base 2 => 5
	; str11 db "+2+",0
	error db "Hi, There's an error here!",10,0
	format db "%d",10,0 ;? Format for the printf call
	format2 db "%s",10,0 ;? Format for the printf call

section .text
	global main
	global ft_atoi_base
	extern ft_strlen
	extern __errno_location
	extern printf
	extern malloc

main:
	; mov rdi, str1
	; mov rsi, str11
	; call ft_atoi_base
	; ;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	; mov rdi, str2
	; mov rsi, str22
	; call ft_atoi_base
	; ;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	; mov rdi, str3
	; mov rsi, str33
	; call ft_atoi_base
	; ;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	; mov rdi, str4
	; mov rsi, str44
	; call ft_atoi_base
	; ;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	; mov rdi, str5
	; mov rsi, str55
	; call ft_atoi_base
	; ;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	; mov rdi, str6
	; mov rsi, str66
	; call ft_atoi_base
	; ;* printf rax
	; mov rsi, rax
	; mov rdi, format
	; xor rax, rax
	; call printf wrt ..plt

	mov rdi, str7
	mov rsi, str77
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
	;TODO First check that both are not empty
	cmp rdi, 0
	je _error_handle
	cmp byte [rdi], 0
	je _error_handle

	cmp rsi, 0
	je _error_handle
	cmp byte [rsi], 0
	je _error_handle

	;TODO got through the base and make sure it contains numbers 
	jmp base_control
	end_base_control:

	;TODO convert the base string into an int
	jmp base_int_converter
	end_loop_base_int_converter:

	;TODO Clean and prepare the string to be worked on
	jmp string_clean_prepare
	done_parsing:


	xor rcx, rcx ;* Will hold the number in int format
	xor rbx, rbx ;* Will hold the the char to be converted
	xor rdx, rdx ;* Will be the max possibile character
	mov r8, rax ;* It will be the sign
	movzx r10, byte [rdi]
	cmp rsi, 16
	je handle_0x
	what:

ft_atoi_base_loop:
	mov rsi, rdi
	mov rdi, format2
	xor rax, rax
	call printf wrt ..plt
	movzx rbx, byte [rdi]
	test bl, bl
	jz end_loop

	;? Check for the sign of the number to be converted is negative then neg the sign in order to muliply it at the end.
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

_error_handle:
	mov rax, 1
	mov rdi, 1
	mov rsi, error
	mov rdx, 28
	syscall

	cmp rax, 0
	jl _syscallError

	mov rax, 60
	xor rdi, rdi
	syscall
	ret

_syscallError:
	mov rbx, rax
	call __errno_location wrt ..plt
	neg rbx
	mov [rax], rbx
	ret

	base_control:
	xor r11, r11
	base_control_loop:
	mov bl, byte [rsi + r11]
	test bl, bl
	jz end_base_control
	cmp bl, 48
	jl not_valid_character
	cmp bl, 57
	jg not_valid_character
	inc r11
	jmp base_control_loop

base_int_converter:
	xor r11, r11
	xor rax, rax
	loopos:
	mov bl, byte [rsi + r11]
	test bl, bl
	jz end_base_int_converter
	sub bl, 48
	movzx rbx, bl
	add rax, rbx
	mov r13, 10
	mul r13
	inc r11
	jmp loopos

end_base_int_converter:
	div r13 ;* so that there is no 0 at the end for example if the base is 2 it will become 20 inorder to avoid that we div by 10 in the r13
	xor rsi, rsi
	mov rsi, rax
	jmp end_loop_base_int_converter

string_clean_prepare:
	xor r11, r11
	mov rax, 1 ;* For sign
	string_clean_prepare_loop_space:
	mov bl, byte [rdi + r11]
	cmp bl, 43
	je end_loop_space
	cmp bl, 45
	je end_loop_space
	cmp bl, 8
	jl not_valid_character
	cmp bl, 13
	jg space_pusher
	back_space:
	inc r11
	jmp string_clean_prepare_loop_space
	end_loop_space:

	loop_for_sign:
	mov bl, byte [rdi + r11]
	cmp bl, 45
	jne sign_shit_control
	je sign_shit
	end_loop_for_sign:

	add rdi, r11
	xor r11, r11
	loop_for_last: ;* You will need to loop and copy into another register
	mov bl, byte [rdi + r11]
	cmp bl, 48
	jl finish
	cmp bl, 57
	jg further_check_2
	back_loop_for_last:
	inc r11
	jmp loop_for_last
	finish:
	mov byte [rdi + r11], 0
	jmp done_parsing

sign_shit_control:
	cmp bl, 43
	jne not_valid_character_maybe ;*<==
	inc r11
	jmp loop_for_sign

not_valid_character_maybe:
	cmp bl, 48
	jl not_valid_character
	cmp bl, 57
	jg further_check_0
	jl end_loop_for_sign ;* <==

further_check_0:
	cmp bl, 65
	jl not_valid_character
	cmp bl, 90
	jg further_check_1
	jl end_loop_for_sign ;* <==

further_check_1:
	cmp bl, 97
	jl not_valid_character
	cmp bl, 122
	jg not_valid_character
	jl end_loop_for_sign ;* <==

further_check_2:
	cmp bl, 65
	jl finish
	cmp bl, 90
	jg further_check_3
	jl back_loop_for_last

further_check_3:
	cmp bl, 97
	jl finish
	cmp bl, 122
	jg finish
	jl back_loop_for_last

space_pusher:
	cmp bl, 32
	jne control_space_num
	jmp back_space

control_space_num:
	cmp bl, 48
	jl not_valid_character
	cmp bl, 57
	jg further_control_space_num
	jl end_loop_space

further_control_space_num:
	cmp bl, 65
	jl not_valid_character
	cmp bl, 90
	jg further_control_space_num_1
	jl end_loop_space

further_control_space_num_1:
	cmp bl, 97
	jl not_valid_character
	cmp bl, 122
	jg not_valid_character
	jl end_loop_space

sign_shit:
	mov r13, -1
	mul r13
	inc r11
	jmp loop_for_sign



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
; -convert the base into an int
; -loop the number to be converted first pass through all type of white spaces
; -second loop through the signs ignoring + and accumilating the -
; -keep looping until char found is not a number and not a-f A-F
; 4) concatinate the string at the last valid char
