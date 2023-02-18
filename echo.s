.data
msg: .asciiz "\nEnter the Input string:\n"  # message to to print before the inputting the string
msg1: .asciiz "Ouput string:\n"   # message before printing the output
string_out: .word 0              # pointer to output string in heap

.text
main:   li $v0 ,9               #allocating 100 bytes space
        li $a0 ,100             #in heap
        syscall
        sw $v0,string_out       # save pointer to the allocated space to string_out
        li $v0 ,4               #printing the first 
        la $a0 ,msg             #message
        syscall

        li $v0 ,8               #reading input string from the console and 
        lw $a0,string_out       #storing it in the string_out pointer
        li $a1,100              # size of string at max 100 bytes
        syscall

        li $v0,4                #printing the second
        la $a0,msg1             #message
        syscall

        li $v0,4                #printing the output
        lw $a0,string_out       #string that is saved in the heap
        syscall

        li $v0 ,10              # exiting the code
        syscall
