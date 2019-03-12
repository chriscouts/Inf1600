.globl _ZNK7CCircle7AreaAsmEv

_ZNK7CCircle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        # Met le pointeur this dans %eax
        mov 8(%ebp), %eax        # %eax = this

        # Push mRadius au dessus de la pile
        fld 4(%eax)               # st[0] = mRadius
        
        # Push mRadius au dessus de la pile
        fld 4(%eax)               # st[0] = st[1] = mRadius
        
        # Multiplie st[0] et stp[1]
        fmulp                   # st[0] = st[1] = mRadius * mRadius

        # Ajoute pi au desus de la pile 
        fldpi                   # st[0] = pi, st[1] = mRadius * mRadius
        
        # Multiplie st[0] et st[1] 
        fmulp                   # st[0] = st[1] = pi * mRadius * mRadius
        
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
