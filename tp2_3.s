.data
	#Considerons que data commence à 0x1000
	i:
	.int a,b,c,d,e
	# a = 0x1000 b = 0x1004 c = 0x1008 d = 0x100C e = 0x1010
.global func_s

func_s:	
	/* Votre programme assembleur ici... */
	
	add $10, %esi	#%esi = 10, pour le for loop

	loop:
	
	mov d, %eax 	#%eax = 0x100C
	mov e, %ebx		#%ebx = 0x1010
	mov b, %ecx		#%ecx = 0x1004
	add %ebx, %eax 	#%eax = 0x201C
	sub %ecx, %eax 	#%eax = 0x1018
	mov %eax, a 	# a	= 0x1018	

	sub $1000, %ecx	#%ecx = 0x1004 - 0x03E8 = 0x0C1C
	mov c , %eax 	#%eax = 0x1008
	add $500, %eax	#%eax = 0x1008 + 0x01F4 = 0x11FC
	cmp %ecx, %eax  #flags = 0x11FC - 0x0C1C
	ja iftrue1		#verifie que flags est > 0
	jna iffalse1	#verifie que flags est <= 0

	iftrue1:

	mov c, %eax		#%eax = 0x1008
	sub $500, %eax 	#%eax = 0x1008 - 0x01F4 = 0x0E14
	mov %eax, c		# c = 0x0E14
	mov b, %ebx		#%ebx = 0x1004
	cmp %eax, %ebx	#flags = 0x1004 - 0x0E14
	ja iftrue2		#verifie que flags est > 0
	jna iffalse2	#verifie que flags est <= 0


	iffalse1:

	mov b, %eax		#%eax = 0x1004
	mov e, %ebx		#%ebx = 0x1010
	sub %ebx, %eax	#%eax = 0x1004 - 0x1010 = -0x000C
	mov %eax, b		# b = -0x000C
	mov d, %eax		#%eax = 0x100C
	add $500, %eax	#%eax = 0x100C + 0x01F4 = 0x1200
	mov %eax, d		# d = 0x1200
	jmp finloop

	iftrue2:

	mov b, %eax		#%eax = 0x1004
	sub $500, %eax	#%eax = 0x1004 - 0x01F4 = 0x0E10
	mov %eax, b 	# b = 0x0E10
	jmp finloop

	iffalse2:

	jmp finloop

	finloop:

	sub $1, %esi	#%esi-- pour le for loop
	je loop			#verifie si %esi = 0 sinon la loop recommence
	
	ret
