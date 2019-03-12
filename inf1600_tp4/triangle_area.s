.data
	factor: .float 2.0 		/* use this to divide by two */
.text
.globl _ZNK9CTriangle7AreaAsmEv

_ZNK9CTriangle7AreaAsmEv:
	push %ebp				/* save old base pointer */
	mov %esp, %ebp			/* set ebp to current esp */
	sub $4, %ebp			# ajoute 4 bytes pour p
	
	movl 8(%ebp), %ebx		# %ebx = CTriangle
	
	# Sauvegarde les sides

	movl 4(%ebx), %eax		# %eax = mSides[0]
	movl 8(%ebx), %ecx		# %ecx = mSides[0]
	movl 12(%ebx), %edx		# %edx = mSides[0]

	# Trouve PerimeterCpp

	movl (%ebx), %ebx		# %ebx = trangle.vtable
	movl 8(%ebx), %ebx		# %ebx = PerimeterCpp

	# Perimeter / 2.0

	fld factor				# st[0] = factor
	fld call *(%ebx)		# st[0] = PerimeterCpp() | st[1] = factor
	fdivp					# st[0] = st[1] = Perimeter.Cpp() / factor

	# Sauvegarde p

	fstp %ebx				# %ebx = PerimeterCpp() / factor
	movl %ebx, -4(%ebp)		# p = %ebx = PerimeterCpp() / factor

	# Sauvegarde p - mSides[0]

	fld %ebx				# st[0] = p
	fld %eax				# st[0] = mSides[0] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[0]
	fstp %eax				# %eax = p - mSides[0]

	# Sauvegarde p - mSides[1]

	fld %ebx				# st[0] = p
	fld %ecx				# st[0] = mSides[1] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[1]
	fstp %ecx				# %eax = p - mSides[1]

	# Sauvegarde p - mSides[2]

	fld %ebx				# st[0] = p
	fld %edx				# st[0] = mSides[2] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[2]
	fstp %edx				# %eax = p - mSides[2]
	
	# p*(p-mSides[0])*(p-mSides[1])*(p-mSides[2])

	fld %ebx				# st[0] = p
	fld %eax				# st[0] = %eax | st[1] = p
	fmulp					# st[0] = st[1] = p * %eax
	
	fld %ecx				# st[0] = %ecx | st[1] = p * %eax
	fmulp					# st[0] = st[1] = p * %eax * %ecx

	fld %edx				# st[0] = %edx | st[1] = p * %eax * %ecx
	fmulp					# st[0] = st[1] = p * %eax * %ecx * %edx

	# Faire le sqrt
	fsqrt					# st[0] = sqrt(p * %eax * %ecx * %edx)
	
	leave					/* restore ebp and esp */
	ret						/* return to the caller */
