/*
* Titre : equals.s
* Date : 11 Mars 2019
* Auteurs : Christophe Couturier et Alexandre Touchette
*/

.globl matrix_equals_asm
 

matrix_equals_asm:
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
		jmp return

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
		imul 16(%ebp), %eax 			# %eax = r * matorder
		mov -8(%ebp), %edx				# %edx = c
		add %edx, %eax					# %eax = r * matorder + c

		mov 8(%ebp), %edx				# %edx = inmatdata1
		mov 12(%ebp), %ebx				# %ebx = inmatdata2

		mov 0(%edx, %eax, 4), %edx		# %edx = inmatdata1[%eax]
		mov 0(%ebx, %eax, 4), %ebx		# %ebx = inmatdata2[%eax]

		cmp %ebx, %edx					# cmp inmatdata1[%eax] et inmatdata2[%eax]
		je for2end						# verifie le flag

		mov $0, %eax					# va return 0
		jmp return
	
	for2end:
		incl -8(%ebp)					# ++c
		jmp for2test

	return: 
		leave          					/* Restore ebp and esp */
		ret           					/* Return to the caller */
