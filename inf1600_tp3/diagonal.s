.global matrix_diagonal_asm

matrix_diagonal_asm:
    push %ebp
	mov %esp, %ebp 						/* Set ebp to current esp */
	sub $8, %esp						# alloue 2 octets pour r et c
	
	movl $0, -4(%ebp)					# r=0
	
	jmp for1test
		
	for1test:
		mov -4(%ebp), %eax
		cmp 16(%ebp), %eax  			# verifie r < matorder
		jb for1
		mov $1, %eax					# va return 1
		leave          					/* Restore ebp and esp */
		ret           					/* Return to the caller */

	for1:
		movl $0, -8(%ebp) 				# c=0
		jmp for2test

	for2test:
		mov -8(%ebp), %ebx
		cmp 16(%ebp), %ebx				# verifie c < matorder
		jb	for2
		incl -4(%ebp)					# ++r
		jmp for1test

	for2:
		mov -4(%ebp), %eax				# %eax = r
        mov -4(%ebp), %ebx				# %ebx = r
		imul 16(%ebp), %eax 			# %eax = r * matorder
		mov -8(%ebp), %edx				# %edx = c
		add %edx, %eax					# %eax = r * matorder + c

        cmp %edx, %ebx      			# compare r et c 
        je  if
		mov 12(%ebp), %ebx				# %ebx = outmatdata
		movl $0, 0(%ebx, %eax, 4)		# outmatdata[%eax] = 0
        jmp for2end

    if:
		mov 8(%ebp), %edx				# %edx = inmatdata
        mov 12(%ebp), %ebx				# %ebx = outmatdata

		mov 0(%edx, %eax, 4), %edx		# %edx = inmatdata[%eax]
        mov %edx, 0(%ebx, %eax, 4)		# outmatdata[%eax] = inmatdata[%eax]
			
	for2end:
		incl -8(%ebp)					# ++c
		jmp for2test

