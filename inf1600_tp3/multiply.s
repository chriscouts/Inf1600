.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        sub $16, %esp           #alloue 4 octets pour r, c, i et elem
        

        movl $0, -4(%ebp)      #r=0
        movl $0, -8(%ebp)      #c=0
        movl $0, -12(%ebp)     #i=0
        movl $0, -16(%ebp)     #elem=0

        jmp for1test

        for1test:
                mov -4(%ebp), %eax      # %eax = r
                cmp 20(%ebp), %eax      # verifie r < matorder
                jb for1         
                mov $1, %eax            # %eax = 1
                jmp return

        for1:
                movl $0, -8(%ebp)        # c = 0
                jmp for2test
        
        for2test:
              	mov  -8(%ebp), %ebx     # %ebx = c
		cmp  20(%ebp), %ebx	# verifie c < matorder
		jb   for2
		incl -4(%ebp)		# ++r
		jmp  for1test  
        
        for2:
                movl $0, -12(%ebp)       # i - 0
                jb for3test

        for3test:
              	mov  -12(%ebp), %ecx    # %ecx = i
		cmp  20(%ebp), %ecx	# verifie i < matorder
		jb   for3
		incl -8(%ebp)		# ++c
		jmp  for3end  

        for3:
          	mov -4(%ebp), %eax	# %eax = r
		imul 20(%ebp), %eax     # %eax = r * matorder  
                mov -12(%ebp), %ecx     # %ecx = i    
                add %ecx, %eax          # %eax = i + r * matorder
                
                mov -8(%ebp), %ebx      # %ebx = c
                imul 20(%ebp), %ecx     # %ecx = i * matorder
                add %ecx, %ebx          # %ebx = c + i * matorder

                mov 8(%ebp), %ecx	# %ecx = inmatdata1
		mov 12(%ebp), %edx	# %edx = inmatdata2

		mov 0(%ecx, %eax, 4), %ecx		# %ecx = inmatdata1[%eax]
		mov 0(%edx, %ebx, 4), %edx		# %edx = inmatdata2[%ebx]    

                imul %ecx, %edx         # %edx = inmatdata1[%eax] * inmatdata2[%ebx] 

                addl %edx, -16(%ebp)          # elem += inmatdata1[%eax] * inmatdata2[%ebx]       


        for3end:   
                incl -12(%ebp)                  # ++i

                mov -4(%ebp), %eax              # %eax = r
                mov -8(%ebp), %ebx              # %ebx = c
                mov 16(%ebp), %ecx              # %ecx = outmatdata

                imul 20(%ebp), %eax             # %eax = r * matorder
                add %ebx, %eax                  # %eax = c + r * matorder

                mov 0(%ecx, %eax, 4), %ecx      # %ecx = outmatdata[%eax]

                mov -16(%ebp), %edx             # %edx = elem
                mov %edx, 0(%ecx, %eax, 4)      # outmatdata[%eax] = %edx
                

		jmp for2test 

        return:
                leave          /* restore ebp and esp */
                ret            /* return to the caller */
