.globl matrix_equals_asm
 

matrix_equals_asm:
	push %ebp
	mov %esp, %ebp 			/* Set ebp to current esp */
	sub $8, %esp			# alloue 2 octets pour r et c
	mov $0, %ecx
	mov %ecx, -4(%ebp)		# r=0
	mov %ecx, -8(%ebp)		# c=0
		
	for:
		mov -4(%ebp), %eax
		cmp 16(%ebp), %eax	# for (r < matorder)
		jl for2				# verifie le flag
		mov $1, %eax		# va return 1
		jmp return

	for2:
		mov -8(%ebp), %ebx
		cmp 16(%ebp), %ebx	# for (c < matorder)
		jl if				# verifie le flag
		add $1, -4(%ebp)
		jmp for				# recommence le 1er for

	if:
				mov -4(%ebp), %eax	# %eax = r
		imul 16(%ebp), %eax # %eax = r * matorder
		mov -8(%ebp), %edx	# %edx = c
		add %edx, %eax		# %eax = r * matorder + c
		mov 8(%ebp), %edx	# %edx = inmatdata1
		add %eax, %edx		# %edx = inmatdata1[%eax]
		mov 12(%ebp), %ebx	# %ebx = inmatdata2
		add %eax, %ebx		# %ebx = inmatdata2[%eax]
		mov (%ebx), %ebx
		cmp %ebx, %edx		# cmp inmatdata1[%eax] et inmatdata2[%eax]
		je incc				# verifie le flag
		mov $0, %eax
		jmp return

	incc:
		add $1, -8(%ebp)
		jmp for2

	return: 
		leave          		/* Restore ebp and esp */
		ret           		/* Return to the caller */
