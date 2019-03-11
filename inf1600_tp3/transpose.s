.globl matrix_transpose_asm

matrix_transpose_asm:
    push %ebp                       		/* save old base pointer */
    mov %esp, %ebp                 			/* set ebp to current esp */
    sub $8, %esp							# alloue 2 octets pour r et c
	
	movl $0, -4(%ebp)						# r=0
	
	jmp for1test
		
	for1test:
		mov -4(%ebp), %eax
		cmp 16(%ebp), %eax      			# verifie r < matorder
		jb for1
		leave          						/* Restore ebp and esp */
		ret           						/* Return to the caller */

	for1:
		movl $0, -8(%ebp) 					# c=0
		jmp for2test

	for2test:
		mov -8(%ebp), %ebx
		cmp 16(%ebp), %ebx					# verifie c < matorder
		jb	for2
		incl -4(%ebp)						# ++r
		jmp for1test

	for2:
		mov -4(%ebp), %eax					# %eax = r
		mov -4(%ebp), %ecx					# %ecx = r
		mov -8(%ebp), %edx					# %edx = c

		imul 16(%ebp), %eax 				# %eax = r * matorder
		add %edx, %eax						# %eax = r * matorder + c

		imul 16(%ebp), %edx 				# %edx = c * matorder
		add %ecx, %edx						# %edx = c * matorder + r

		mov 8(%ebp), %ecx					# %ecx = inmatdata
		mov 12(%ebp), %ebx					# %ebx = outmatdata

		mov 0(%ecx, %edx, 4), %ecx			# %ecx = inmatdata[%edx]
		mov %ecx, 0(%ebx, %eax, 4)    		# %ebx = outmatdata[%eax] = inmatdata[%edx]
		

	for2end:
	    incl -8(%ebp)						# ++c
		jmp for2test
