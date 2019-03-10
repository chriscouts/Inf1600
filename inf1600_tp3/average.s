.global matrix_row_aver_asm

matrix_row_aver_asm:
    push %ebp                       /* save old base pointer */
    mov %esp, %ebp                  /* set ebp to current esp */
    sub $12, %esp			# alloue 3 octets pour r, c et elem
	
	movl $0, -4(%ebp)		# r=0
	
	jmp for1test
		
	for1test:
		mov -4(%ebp), %eax
		cmp 16(%ebp), %eax      # verifie r < matorder
		jb for1
		leave          		/* Restore ebp and esp */
		ret           		/* Return to the caller */

	for1:
		movl $0, -8(%ebp) 	# c=0
        movl $0, -12(%ebp)  # elem = 0
		jmp for2test

	for2test:
		mov -8(%ebp), %ebx
		cmp 16(%ebp), %ebx	# verifie c < matorder
		jb	for2

        mov -4(%ebp), %eax	# %eax = r
		mov 12(%ebp), %ebx	# %ebx = outmatdata
        mov -12(%ebp), %ecx # %ecx = elem

        idiv %ecx    # %ecx = elem/matorder
        mov %ecx, 0(%ebx, %eax, 4)     # %ebx = outmatdata[r] = elem/matorder

		incl -4(%ebp)		# ++r
		jmp for1test

	for2:
		mov -4(%ebp), %eax	# %eax = r
		mov -8(%ebp), %edx	# %edx = c

		imul 16(%ebp), %eax # %eax = r * matorder
		add %edx, %eax		# %eax = r * matorder + c

		mov 8(%ebp), %ecx	# %ecx = inmatdata
		
		mov 0(%ecx, %edx, 4), %ecx	    # %ecx = inmatdata[%edx]
		addl %ecx, -12(%ebp)            # elem += inmatdata[%edx]
		

	for2end:
	    incl -8(%ebp)		# ++c
		jmp for2test
