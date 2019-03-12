.data
	factor: .float 2.0 		/* use this to divide by two */
.text
.globl _ZNK9CTriangle7AreaAsmEv

_ZNK9CTriangle7AreaAsmEv:
	push %ebp				/* save old base pointer */
	mov %esp, %ebp			/* set ebp to current esp */
	pusha 
	
	movl 8(%ebp), %ebx		# %ebx = this
	movl (%ebx), %ebx		# %ebx = triangle.vtable

	# Perimeter / 2.0

	push 8(%ebp)
	call *8(%ebx)			# st[0] = PerimeterCpp()
	fld factor				# st[0] = factor | st[1] = PerimeterCpp()
	pop 8(%ebp)
	fdivp					# st[0] = st[1] = Perimeter.Cpp() / factor

	# Sauvegarde p

	fstp -4(%ebp)			# %ebx = PerimeterCpp() / factor

	# p - mSides[0]

	fld -4(%ebp)			# st[0] = p
	fld 4(%ebx)				# st[0] = mSides[0] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[0]

	# p - mSides[1]

	fld -4(%ebp)			# st[0] = p
	fld 8(%ebx)				# st[0] = mSides[1] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[1]

	# p - mSides[2]

	fld -4(%ebp)			# st[0] = p
	fld 12(%ebx)			# st[0] = mSides[2] | st[1] = p
	fsubrp					# st[0] = st[1] = p - mSides[2]
	
	# p*(p-mSides[0])*(p-mSides[1])*(p-mSides[2])

	fld -4(%ebp)			# st[0] = p
	
	fmulp					# st[0] = st[1] = p * %eax
	fstp %eax
	fmulp					# st[0] = st[1] = p * %eax * %ecx
	
	fmulp					# st[0] = st[1] = p * %eax * %ecx * %edx

	# Faire le sqrt
	fsqrt					# st[0] = sqrt(p * %eax * %ecx * %edx)
	
	popa
	leave					/* restore ebp and esp */
	ret						/* return to the caller */
