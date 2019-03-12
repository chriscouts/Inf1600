.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        # Met le pointeur this dans %eax
        mov 8(%ebp), %eax        # %eax = this
        
        # Met le premier côté dans %ebx
        mov 4(%eax), %ebx       # %ebx = mSides[0]

        # Met le deuxième côté dans %ecx
        mov 4(%eax), %ecx       # %ecx = mSides[1]

        # Met %ebx au dessus de la pile
        push %ebx               # st[0] = %ebx

        # Met %ecx au dessus de la pile
        push %ecx               # st[0] = %ecx, st[0] = %eax

        # Additione les côtés mSides[1] et mSides[0]
        faddp                   #st[0] = st[1] = %ebx + %ecx = mSides[1] + mSides[0]

        # Met le troisième côté dans %edx
        mov 4(%eax), %edx       # %edx = mSides[2]

        # Additione le troisième côté au deux premier
        faddp                   # st[0] = st[1] = mSides[2] + (mSides)[1] + mSides[0])

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
