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

	# movl 4(%ebx), %eax		# %eax = mSides[0]
	# movl 8(%ebx), %ecx		# %ecx = mSides[0]
	# movl 12(%ebx), %edx		# %edx = mSides[0]

	# Trouve PerimeterCpp

	movl (%ebx), %eax		# %ebx = triangle.vtable

	# Perimeter / 2.0

	fld factor				# st[0] = factor
	push 8(%ebp)
	call *(%ebx)			# st[0] = PerimeterCpp() | st[1] = factor
	fdivp					# st[0] = st[1] = Perimeter.Cpp() / factor

	# Sauvegarde p

	fstp (%eax)				# %ebx = PerimeterCpp() / factor
	movl %eax, -4(%ebp)		# p = %ebx = PerimeterCpp() / factor

	# Sauvegarde p - mSides[0]

	fld 8(%eax)				# st[0] = p
	fld 4(%ebx)				# st[0] = mSides[0] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[0]
	fstp 4(%ebx)				# %eax = p - mSides[0]

	# Sauvegarde p - mSides[1]

	fld 8(%eax)				# st[0] = p
	fld 8(%ebx)				# st[0] = mSides[1] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[1]
	fstp 8(%ebx)				# %eax = p - mSides[1]

	# Sauvegarde p - mSides[2]

	fld 8(%eax)				# st[0] = p
	fld 12(%ebx)				# st[0] = mSides[2] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[2]
	fstp 12(%ebx)				# %eax = p - mSides[2]
	
	# p*(p-mSides[0])*(p-mSides[1])*(p-mSides[2])

	fld 8(%eax)				# st[0] = p
	fld 4(%ebx)				# st[0] = %eax | st[1] = p
	fmulp					# st[0] = st[1] = p * %eax
	
	fld 8(%ebx)				# st[0] = %ecx | st[1] = p * %eax
	fmulp					# st[0] = st[1] = p * %eax * %ecx

	fld 12(%ebx)				# st[0] = %edx | st[1] = p * %eax * %ecx
	fmulp					# st[0] = st[1] = p * %eax * %ecx * %edx

	# Faire le sqrt
	fsqrt					# st[0] = sqrt(p * %eax * %ecx * %edx)
	
	leave					/* restore ebp and esp */
	ret						/* return to the caller */
