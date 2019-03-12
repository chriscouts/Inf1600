.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK7CCircle12PerimeterAsmEv

_ZNK7CCircle12PerimeterAsmEv:
        push %ebp               /* save old base pointer */
        mov %esp, %ebp          /* set ebp to current esp */
		pusha

	
        movl 8(%ebp), %ebx       # %ebx = CCircle

		# Ajouter mRadius sur la pile de float
		fld 4(%ebx)				# st[0] =  mRadius

		# Ajouter PI sur la pile de float
		fldpi					# st[0] = PI | st[1] = mRadius
		
		# PI * mRadius
		fmulp					# st[0] = st[1] = PI * mRadius

		# Ajouter factor sur la pile de float
		fld factor				# st[0] = factor | st[1] = PI * mRadius

		# 2.0 * PI * mRadius
		fmulp					# st[0] = st[1] = PI * mRadius * factor

		popa
        leave					/* restore ebp and esp */
        ret						/* return to the caller */
