# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
    li      $v0, 9                  #allocate dynamic memory system call code
    li      $a0, 120                #120 bytes of memory
    syscall                         #system call this stores the starting address of heap in v0 register
    sw      $v0, heap_pointer       #saving the begin address of heap
    j       input


input:
#    la      $t1, array              #loading the starting address of array
#      Printing msg1: "Enter the number of elements\n"
    li      $v0, 4
    la      $a0, msg1
    syscall

#   Taking the no of inputs
    li      $v0, 5
    syscall

    add     $t3, $zero, $v0           # number of array is loaded to t3
    lw      $t2, heap_pointer       #loading heap_pointer to register t2
    li      $t0, 0                  #loading 0 to t0  int i=0;  

#      Printing ms2:   "Enter the numbers\n"  
    li      $v0, 4
    la      $a0, msg2
    syscall        
    j       input_loop


input_loop:
    bge     $t0, $t3, bef_while      # if i >= size branch to while

    li      $v0, 5
    syscall
    sw      $v0, ($t2)              #  storing intput value t4 to address in t2
    addi    $t2, $t2, 4             #    incrementing the address stored by t1 by 4 bytes(size of a word)
    addi    $t0, $t0, 1             # incrementin i  i.e. value stored in t0
    j       input_loop

bef_while: # before while
    #bgt Rsrc1, Src2, label Branch on Greater Than Conditionally branch to the instruction at the label if
    #the contents of register Rsrc1 are greater than Src2.
    li      $v0, 4
    la      $a0,msg3
    syscall

    li      $v0, 5
    syscall
    add     $t7, $zero, $v0

    li      $t0,  0                 # int i=0*4
    addi    $t1, $t3, -1             #int j = size -1
    #sll     $t1, $t1, 2             # t1 = j*4 
    addi    $t2, $zero, -1          #int index = -1  i.e.   t2 stores the index
    lw      $t3, heap_pointer       # begin address of heap

while:
    bgt     $t0, $t1, print_1        #while(i <=j) i.e if i > j then jump to print1
    add     $t5, $t0, $t1           # register t5 stores  (i+j)
    srl     $t5, $t5, 1             # register t5 stores int mid = (i+j), i.e. t5 = mid
    sll     $t5, $t5, 2             #  mid * 4
    add     $t4, $t5, $t3           # t4 = base address + mid
    srl     $t5, $t5, 2
    lw      $t6, 0($t4)              #  s0 = arr[mid]
    beq     $t7, $t6, L1            # if(x == arr[mid])  branch to L1
    bgt     $t7, $t6, L2            # else if( x > arr[mid])  branch to L2
    j       L3                      # else  branch to L3

L1:
    add     $t2, $zero, $t5     #index = mid*4
    addi    $t1, $t5, -1         #  j = mid - 1
    j       while

L2:
    addi    $t0, $t5, 1       # i = mid + 1
    j       while

L3:
    addi    $t1, $t5, -1         #  j = j - 1
    j       while

print_1:
    add    $t0,$zero,-1
    beq     $t2, $t0, No_ind
    li      $v0, 4
    la      $a0, msg5
    syscall
    li      $v0, 1
    move    $a0, $t2
    syscall
    j       end
No_ind:
    li      $v0, 4
    la      $a0, msg4
    syscall

end:
    li      $v0, 10
    syscall


.data     
#array:         .word 1, 2, 3, 3, 4, 5, 8, 9, 15, 17, 23, 27, 29, 32, 35, 37, 38, 39, 41, 46, 59, 67, 80, 90, 93, 96, 98, 100, 101, 120    
#size:          .word 30
#value:         .word 0
heap_pointer:  .word 0
msg1:          .asciiz "Enter the number of elements\n"
msg2:          .asciiz "Enter the numbers\n"
msg3:          .asciiz " Enter the value to Search\n"
msg4:          .asciiz "Index not found\n"
msg5:          .asciiz "Index is found is :\n"



    

