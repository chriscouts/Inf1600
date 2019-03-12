.globl	_ZNK9CTriangle9HeightAsmEv

_ZNK9CTriangle9HeightAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        sub $4, (%ebp)                     # Ajoute 4 byte pour A

        movl 8(%ebp), %eax              # %eax = this
        movl (%eax), %ebx               # %eax = triangle.vtable 
        movl 12(%ebx), %ebx             # %eax = Areacpp

        # Multiplication 2.0f * A
        fld factor                      # st[0] = factor
        push 8(%ebp)
        call *(%ebx)                # st[0] = Areacpp, st[1] factor
        fmulp                           # st[0] = st[1] = factor * Areacpp

        # Division (2.0f * A) / mSides[2]
        movl 12(%eax), %ecx             # %ecx = mSides[2]
        fld %ecx                       # st[0] = %ecx, st[1] = factor * Areacpp
        fdivrp                          # st[0] = st[1] = (factor * Areacpp) / mSides[2]
        



        leave          /* restore ebp and esp */
        ret            /* return to the caller */
