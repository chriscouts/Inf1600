.data
	factor: .float 2.0 		/* use this to divide by two */
.text
.globl	_ZNK9CTriangle9HeightAsmEv

_ZNK9CTriangle9HeightAsmEv:
	push %ebp      					/* save old base pointer */
	mov %esp, %ebp 					/* set ebp to current esp */
	pusha

	movl 8(%ebp), %eax              # %eax = this
	movl (%eax), %ebx               # %eax = triangle.vtable 
       

	# Multiplication 2.0f * A
	push 8(%ebp)
	call *16(%ebx)                  # st[0] = Areacpp, st[1] factor
	fld factor                      # st[0] = factor
	pop 8(%ebp)
	fmulp                           # st[0] = st[1] = factor * Areacpp

	# Division (2.0f * A) / mSides[2]
	
	fld 12(%eax)                    # st[0] = 12(%eax) = mSides[2] st[1] = factor * Areacpp
	fdivrp                          # st[0] = st[1] = (factor * Areacpp) / mSides[2]

	popa
	leave          					/* restore ebp and esp */
	ret           					/* return to the caller */
