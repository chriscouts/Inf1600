.globl _ZNK7CCircle7AreaAsmEv

_ZNK7CCircle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        # Mettre le pointeur this dans %eax
        mov (this), %eax        # %eax = this

        # Met le mRadius dans %ebx
        mov 4((this)), %ebx     # %ebx = mRadius

        # Met le mRadius dans %ebx
        mov 4((this)), %ecx     # %ecx = mRadius

        # Push %ebx au dessus de la pile
        push %ebx               # st[0] = mRadius
        
        # Push %ecx au dessus de la pile
        push %ecx               # st[0] = st[1] = mRadius
        
        # Multiplie st[0] et stp[1]
        fmulp                   # st[0] = st[1] = mRadius * mRadius

        # Ajoute pi au desus de la pile 
        fldpi                   # st[0] = pi, st[1] = mRadius * mRadius
        
        # Multiplie st[0] et st[1] 
        fmulp                   # st[0] = st[1] = pi * mRadius * mRadius
        
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
