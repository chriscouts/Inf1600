.data
	#Considerons que data commence à 0x1000
	i:
	.int a,b,c,d,e
	# a = 0x1000 b = 0x1004 c = 0x1008 d = 0x100C e = 0x1010
.global func_s

func_s:	
	/* Votre programme assembleur ici... */
	
	mov $0, %ecx				#%ecx = 0
	jmp test
	
	for:
		#a=d+e-b
		mov d, %eax 			#%eax = 0x100C
		mov e, %ebx				#%ebx = 0x1010
		mov b, %edx				#%edx = 0x1004
		add %ebx, %eax 			#%eax = 0x201C
		sub %edx, %eax 			#%eax = 0x1018
		mov %eax, a 			# a	= 0x1018

		#premier if
		sub $1000, %edx			#%edx = 0x1004 - 0x03E8 = 0x0C1C
		mov c , %eax 			#%eax = 0x1008
		add $500, %eax			#%eax = 0x1008 + 0x01F4 = 0x11FC
		cmp %edx, %eax 			#flags = 0x11FC - 0x0C1C
		jna else				#verifie que flags est > 0
		jmp iftrue1				#envoie a true sinon

	iftrue1:
		mov c, %eax				#%eax = 0x1008
		sub $500, %eax 			#%eax = 0x1008 - 0x01F4 = 0x0E14
		mov %eax, c				# c = 0x0E14
		mov b, %ebx				#%ebx = 0x1004
		mov c, %eax
		
		#deuxieme if
		cmp %eax, %ebx			#flags = 0x1004 - 0x0E14
		jna increment			#verifie que flags est > 0
		jmp iftrue2

	iftrue2:
		sub $500, %ebx			#%ebx = 0x1004 - 0x01F4 = 0x0E10
		mov %ebx, b 			# b = 0x0E10
		jmp increment

	else:
		#code du else
		mov b, %eax				#%eax = 0x1004
		mov e, %ebx				#%ebx = 0x1010
		sub %ebx, %eax			#%eax = 0x1004 - 0x1010 = -0x000C
		mov %eax, b				# b = -0x000C
		mov d, %eax				#%eax = 0x100C
		add $500, %eax			#%eax = 0x100C + 0x01F4 = 0x1200
		mov %eax, d				# d = 0x1200
		jmp increment

	increment:
		inc %ecx				#%ecx++
			
	test:
		cmp $10, %ecx			#verifie si %ecx = 10
		jnae for				#verifie si flags est <0 pour que la loop recommence
		ret		
