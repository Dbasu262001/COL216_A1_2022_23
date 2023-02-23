.data
msg: .asciiz "\nEnter the inputs:\n" # message to print at the start of main program

.text
main:   li $v0 ,4       #print the msg
        la $a0 ,msg     #to the console
        syscall
        li $v0,5        #taking input x from the console
        syscall
        add $t0,$0,$v0  #storing x to t0
        li $v0,5        #taking input n from the console
        syscall
        add $t1,$0,$v0  #storing n in t1
        move $a0,$t0    #move x to a0
        move $a1,$t1    #move n to a1
        li  $v1,1       #load value 1 to v1
        jal Fast_Exp    #calling fast exponential function on input x,n and store the output in v1
        li $v0,1        #print output v1
        move $a0,$v1    # to console
        syscall
        li $v0,10       # terminating the program
        syscall

Fast_Exp:  # value of x stores in a0 and value of n in a1
           subu $sp,$sp,8        # decrementing the stack pointer
           sw  $ra,($sp)         #storing the return address
           sw  $s0,4($sp)        #value into stack pointer
           beq $a1,0,N_0         # if n=0 execute N_0
           li  $s0,2             # load value 2 to s0
           div $a1,$s0           # storing remainder of
           mfhi $t0              # n/2 to t0
           bne $t0,0,odd         # if t0 is 1 then n is odd so execute odd
            div $a1,$a1,$s0      # n=n/2
           jal Fast_Exp          # call the Fast_Exp on input x,n/2 and returns it to v1
           mul $v1,$v1,$v1       # v1=v1**2 ,since v1=Fast_Exp(x,n/2)
           N_0: lw  $ra,($sp)    # loading values from the stack 
                lw  $s0,4($sp)   # pointers to registers
                addu $sp,$sp,8   # incrementing the stack pointer to its previous
                jr $ra           # return the function
           

odd:    #case when n%2 not equals 0
        div $a1,$a1,$s0  #n=n/2
        jal Fast_Exp     # calling Fast_Exp on x,n/2 
        mul $v1,$v1,$v1  # v1=v1**2 ,since v1=Fast_Exp(x,n/2)
        mul $v1,$v1,$a0  # since n is odd , so v1=v1*x
        b  N_0           # jump to N_0
        








