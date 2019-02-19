.globl matrix_equals_asm
 

matrix_equals_asm:
push %ebp
	mov %esp, %ebp 			/* Set ebp to current esp */
	sub $8, %esp			#alloue 2 octets pour r et c
	mov $0, %eax
	mov %eax, -4(%ebp)		#r=0
	mov %eax, -8(%ebp)		#c=0
	
	jmp for

	for:
		mov -4(%ebp), %eax
		cmp 16(%ebp), %eax	#for (r < matorder)
		jnae for2		#verifie le flag
		leave
		ret

	for2:
		mov -8(%ebp), %ebx
		cmp 16(%ebp), %ebx	#for (c < matorder)
		jnae if			#verifie le flag
		inc %ebx		#%ebx++
		mov %ebx, -8(%ebp)
		cmp 16(%ebp), %ebx	#for (c < matorder)
		jnae for2		#recommence la loop
		mov -4(%ebp), %eax
		inc %eax		#%eax++
		mov %eax, -4(%ebp)
		jmp for

	if:
		imul 16(%ebp), %eax	# matorder * r
		add %ebx, %eax		# c + matorder * r
		mov 12(%ebp), %ecx
		add %eax, %ecx
		mov 8(%ebp), %edx
		add %eax, %edx
		mov (%ecx), %ecx
		cmp %ecx, (%edx)
		jne return
		inc %ebx		#%ebx++
		mov %ebx, -8(%ebp)
		jmp for2

	return: 
		leave          		/* Restore ebp and esp */
		ret           	/* Return to the caller */
