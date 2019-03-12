.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
	push %ebp      					/* save old base pointer */
	mov %esp, %ebp 					/* set ebp to current esp */
	pusha
	
	# Met le pointeur this dans %eax

	movl 8(%ebp), %eax				# %eax = this
	
	# Met 1er cote au dessus de la pile

	fld  4(%eax)					# st[0] = mSides[0]

	# Met 2e cote au dessus de la pile

	fld  8(%eax) 					# st[0] = mSides[1], st[1] = mSides[0]

	# Additione les côtés mSides[1] et mSides[0]

	faddp							# st[0] = st[1] = %ebx + %ecx = mSides[1] + mSides[0]

	# Met 3e cote au dessus de la pile

	fld  12(%eax)					# st[0] = mSides[2], st[1] = mSides[1] + mSides[0]

	# Additione le troisième côté au deux premier

	faddp							# st[0] = st[1] = mSides[2] + (mSides)[1] + mSides[0])

	popa
	leave          					/* restore ebp and esp */
	ret            					/* return to the caller */
