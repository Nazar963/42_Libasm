section .data
	format_v db "%d", 10, 0 ;? Format for the printf call
	format_p db "%p", 10, 0 ;? Format for the printf call

section .text
	global main
	extern __errno_location
	extern printf
	extern malloc
	extern free

;? void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
;? The nodes are r12 - rbp - rbx

main:
;* -------------------------------------------------------------------------- */
;*                                  Last node                                 */
;* -------------------------------------------------------------------------- */
	mov rdi, 16
	call malloc wrt ..plt
	test rax, rax
	jz _malloc_error

	mov rbx, rax
	mov qword [rbx], 5
	mov qword [rbx + 8], 0

;* -------------------------------------------------------------------------- */
;*                                 Second node                                */
;* -------------------------------------------------------------------------- */
	mov rdi, 16
	call malloc wrt ..plt
	test rax, rax
	jz _malloc_error

	mov rbp, rax
	mov qword [rbp], 10
	mov qword [rbp + 8], rbx

;* -------------------------------------------------------------------------- */
;*                                 First node                                 */
;* -------------------------------------------------------------------------- */
	mov rdi, 16
	call malloc wrt ..plt
	test rax, rax
	jz _malloc_error

	mov r12, rax
	mov qword [r12], 15
	mov qword [r12 + 8], rcx

;* -------------------------------------------------------------------------- */
;*                              Print first node                              */
;* -------------------------------------------------------------------------- */
	; push r12
	; mov rsi, r12
	; mov rdi, format_p
	; xor rax, rax
	; call printf wrt ..plt

	; pop r12
	; push r12
	; mov rsi, [r12]
	; mov rdi, format_v
	; xor rax, rax
	; call printf wrt ..plt

	; pop r12
	; mov rsi, [r12 + 8]
	; mov rdi, format_p
	; xor rax, rax
	; call printf wrt ..plt

;* -------------------------------------------------------------------------- */
;*                              Print second node                             */
;* -------------------------------------------------------------------------- */
	; push rbp
	; mov rsi, rbp
	; mov rdi, format_p
	; xor rax, rax
	; call printf wrt ..plt

	; pop rbp
	; push rbp
	; mov rsi, [rbp]
	; mov rdi, format_v
	; xor rax, rax
	; call printf wrt ..plt

	; pop rbp
	; mov rsi, [rbp + 8]
	; mov rdi, format_p
	; xor rax, rax
	; call printf wrt ..plt

;* -------------------------------------------------------------------------- */
;*                               Print last node                              */
;* -------------------------------------------------------------------------- */
	; push rbx
	; mov rsi, rbx
	; mov rdi, format_p
	; xor rax, rax
	; call printf wrt ..plt

	; pop rbx
	; push rbx
	; mov rsi, [rbx]
	; mov rdi, format_v
	; xor rax, rax
	; call printf wrt ..plt

	; pop rbx
	; mov rsi, [rbx + 8]
	; mov rdi, format_p
	; xor rax, rax
	; call printf wrt ..plt

;* -------------------------------------------------------------------------- */
;*                            Call for the function                           */
;* -------------------------------------------------------------------------- */
	mov rdi, r12 ;* ==> First parameter send the head of the linked list
	mov rsi, 5 ;* ==> Second parameter send the value to be compared with
	mov rdx, cmp ;* ==> Third parameter send the function pointer of the cmp function for the comparison
	mov rcx, free_fct ;* ==> Fourth parameter send the function pointer of the free function for the freeing
	call ft_list_remove_if

;/ -------------------------------------------------------------------------- */
	mov rax, 60
	xor rdi, rdi
	syscall

; Function: ft_list_remove_if
; Arguments:
;   RDI - * to the head of the node
;   RSI - value to be compared
;		RDX - function pointer for the function cmp
;		RCX - function pointer for the function free
; Returns:
; * @param    the linked list modified
ft_list_remove_if:
	; mov r8, [rdi] ;? Dereference the pointer of the pointer
	mov r8, rdi

	xor rdi, rdi
	mov rax, rdx

	loop_list:
	test r8, r8
	jz end_program
	mov rdi, r8
	call cmp
	cmp rax, 0
	je clean_and_replace
	mov r8, [r8 + 8]
	jmp loop_list

	ret

clean_and_replace:
	mov rax, rcx ;* Move the funciton
	
	; mov rdi, [r8] ;* Move the value => Maybe this line is creating the segfault.
	mov rdi, r8

	call rax ;* Call the function
	
	mov rdi, 8 ;* Allocate 8 bytes of memeory
	call malloc wrt ..plt

	mov [r8], rax ;* Move the pointer to point for the value space in the node
	mov qword [r8], 9 ;* Place another value.

	cmp r8, 0 ;? To check if this node is the last
	je end_program
	mov r8, [r8 + 8]
	jmp loop_list

end_program:
	ret

;* --------------------------------------------------------------------------
; Function: cmp
; Arguments:
;   RDI - list_ptr
;   RSI - data_ref
; Returns:
;   0 on success (comparison is equal), otherwise non-zero
cmp:
	; Load list_ptr->data into RAX
	mov rax, [rdi]
	; mov rax, [rax] ;! This is not needed as rdi is the pointer of the node and not a pointer to a pointer to the node

	; Compare list_ptr->data (RAX) with data_ref (RSI)
	cmp rax, rsi

	; Set AL to 1 if equal, 0 if not
	sete al

	; Convert AL (1 or 0) to its integer representation
	movzx eax, al

	; Invert EAX so it returns 0 if equal, 1 if not
	xor eax, 1

	; Clear upper bits of RAX (for return value)
	; and eax, 0xFF

	; Return (RAX will be 0 if equal, non-zero otherwise)
	ret

;* --------------------------------------------------------------------------
; Function: free_fct
; Argument:
;   RDI - list_ptr
free_fct:
	;TODO: should check the position of the node to be deleted:

	;* Check if the node to be deleted is the first node by
	;* Checking the position - 16 if its null
	; The pointer to free is already in RDI (calling convention)
	; mov rdi, rdi  ; Not needed, already in correct register

	; Call the free function
	; Note: The actual 'free' should be linked from a C library or implemented
	call free wrt ..plt

	; Return
	ret

_malloc_error:
	mov rax, -1
	ret







;TODO -------------------------------------------------------------------------- */
;TODO -------------------------------------------------------------------------- */
;TODO -------------------------------------------------------------------------- */
; section .data
; 	format_v db "%d",10,0 ;? Format for the printf call
; 	format_p db "%p",10,0 ;? Format for the printf call

; section .text
; 	global main
; 	extern __errno_location
; 	extern printf
; 	extern malloc
; 	extern free

; ; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))

; main:
; 	mov rdi, 16
; 	call malloc wrt ..plt
; 	cmp rax, 0 ;! ==> it should be test rax, rax and the jz
; 	jl _malloc_error

; 	mov rbx, rax
; 	mov qword [rbx], 5
; 	mov qword [rbx + 8], 0


; 	mov rdi, 16
; 	call malloc wrt ..plt
; 	cmp rax, 0
; 	jl _malloc_error

; 	;* In order to get the pointer of a pointer to the function call.
; 	; push rax
; 	; lea rdi, [rsp]
; 	; mov rax, [rsp]
; 	mov rdi, rax

; 	mov qword [rdi], 10
; 	mov qword [rdi + 8], rbx

; 	mov rsi, 5
; 	mov rdx, cmp
; 	mov rcx, free_fct
; 	call ft_list_remove_if
; 	add rsp, 8 ;? Restore the stack head its original position.


; 	; mov rbx, rax
; 	; mov rcx, [rax + 8]
; 	; ;* printf rax
; 	; push rbx
; 	; mov rsi, rbx
; 	; mov rdi, format2
; 	; xor rax, rax
; 	; call printf wrt ..plt

; 	; pop rbx
; 	; mov rsi, [rbx]
; 	; mov rdi, format
; 	; xor rax, rax
; 	; call printf wrt ..plt

; 	; mov rsi, [rbx + 8]
; 	; mov rdi, format2
; 	; xor rax, rax
; 	; call printf wrt ..plt

; 	; push rcx
; 	; mov rsi, rcx
; 	; mov rdi, format2
; 	; xor rax, rax
; 	; call printf wrt ..plt

; 	; pop rcx

; 	; mov rsi, [rcx]
; 	; mov rdi, format
; 	; xor rax, rax
; 	; call printf wrt ..plt

; 	; mov rsi, [rcx + 8]
; 	; mov rdi, format2
; 	; xor rax, rax
; 	; call printf wrt ..plt

; 	mov rax, 60
; 	xor rdi, rdi
; 	syscall

; ft_list_remove_if:
; 	; mov r8, [rdi] ;? Dereference the pointer of the pointer
; 	mov r8, rdi

; 	xor rdi, rdi
; 	mov rax, rdx

; 	loop_list:
; 	test r8, r8
; 	jz end_program
; 	mov rdi, r8
; 	call cmp
; 	cmp rax, 0
; 	je clean_and_replace
; 	mov r8, [r8 + 8]
; 	jmp loop_list

; 	ret

; clean_and_replace:
; 	mov rax, rcx ;* Move the funciton
	
; 	; mov rdi, [r8] ;* Move the value => Maybe this line is creating the segfault.
; 	mov rdi, r8

; 	call rax ;* Call the function
	
; 	mov rdi, 8 ;* Allocate 8 bytes of memeory
; 	call malloc wrt ..plt

; 	mov [r8], rax ;* Move the pointer to point for the value space in the node
; 	mov qword [r8], 9 ;* Place another value.

; 	cmp r8, 0 ;? To check if this node is the last
; 	je end_program
; 	mov r8, [r8 + 8]
; 	jmp loop_list

; end_program:
; 	ret

; ;* --------------------------------------------------------------------------
; ; Function: cmp
; ; Arguments:
; ;   RDI - list_ptr
; ;   RSI - data_ref
; ; Returns:
; ;   0 on success (comparison is equal), otherwise non-zero
; cmp:
; 	; Load list_ptr->data into RAX
; 	mov rax, [rdi]
; 	; mov rax, [rax] ;! This is not needed as rdi is the pointer of the node and not a pointer to a pointer to the node

; 	; Compare list_ptr->data (RAX) with data_ref (RSI)
; 	cmp rax, rsi

; 	; Set AL to 1 if equal, 0 if not
; 	sete al

; 	; Convert AL (1 or 0) to its integer representation
; 	movzx eax, al

; 	; Invert EAX so it returns 0 if equal, 1 if not
; 	xor eax, 1

; 	; Clear upper bits of RAX (for return value)
; 	; and eax, 0xFF

; 	; Return (RAX will be 0 if equal, non-zero otherwise)
; 	ret

; ;* --------------------------------------------------------------------------
; ; Function: free_fct
; ; Argument:
; ;   RDI - list_ptr
; free_fct:
; 	; Call the free function
; 	; Note: The actual 'free' should be linked from a C library or implemented
; 	call free wrt ..plt

; 	; Return
; 	ret

; _malloc_error:
; 	mov rax, -1
; 	ret