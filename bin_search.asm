#Declaring the global main function
	.globl main  #

	.text 	 # text assembler directive	

# The label 'main' represents the starting point

main:                       
    #allocating dynamic memory of 120 bytes, i.e, maximum 30 integers can be stored
    li      $v0, 9                  #allocate dynamic memory system call code
    li      $a0, 120                #120 bytes of memory
    syscall                         #system call this stores the starting address of heap in v0 register
    sw      $v0, heap_pointer       #saving the begin address of heap
    j       input


input:
    # Displaying a message to enter the number of inputs
    li      $v0, 4
    la      $a0, msg1
    syscall

#   Taking the no of inputs  syscall code no 5 is used to read integer, the integer is stored in $vo after syscall

    li      $v0, 5
    syscall

    add     $t3, $zero, $v0           # number of array is moved to t3
    lw      $t2, heap_pointer         #loading heap_pointer to register t2
    li      $t0, 0                    #loading 0 to t0  int i=0;  intializing index i

#      Printing ms2:   "Enter the numbers one by one, Press Enter key after every input \n"  
    li      $v0, 4
    la      $a0, msg2
    syscall        
    j       input_loop

#Loop for taking input of all the integers in the  array

input_loop:                     

    bge     $t0, $t3, bef_while      # if i >= n (size of array) branch to bef_while
    li      $v0, 5                   #5 is the syscall code to read integer, syscall no is always stored in $v0 register before syscall
    syscall

    sw      $v0, ($t2)              #  storing intput value t4 to address in t2
    addi    $t2, $t2, 4             #   incrementing the address stored by t1 by 4 bytes(size of a word)
    addi    $t0, $t0, 1             # incrementin i  i.e. value stored in t0
    j       input_loop

bef_while:              # before_while label

 # Displaying message to enter the value to Search
    li      $v0, 4      
    la      $a0,msg3
    syscall

#Taking the input value to Search
    li      $v0, 5
    syscall
    add     $t7, $zero, $v0         # Value to be Searched is stored in register t7 or $t7 = x

    li      $t0,  0                 # int i=0   
    addi    $t1, $t3, -1            #int j = size -1
    addi    $t2, $zero, -1          #int index = -1  i.e.   t2 stores the index of x
    lw      $t3, heap_pointer       # begin address of heap is stored is t3 register

while:
    bgt     $t0, $t1, print_1       #while(i <=j) i.e., if i > j then jump to label print_1, i.e exiting the while loop
    add     $t5, $t0, $t1           # register t5 stores  (i+j)
    srl     $t5, $t5, 1             # register t5 stores int mid = (i+j)/2 , i.e. t5 = mid
    sll     $t5, $t5, 2             #  t5 = mid * 4 
    add     $t4, $t5, $t3           # t4 = base address + mid
    srl     $t5, $t5, 2             # t5 = t5/4 i.e, t5 = mid = (i+j)/2
    lw      $t6, 0($t4)             #  t0 = arr[mid]
    beq     $t7, $t6, L1            # if(x == arr[mid])  branch to L1
    bgt     $t7, $t6, L2            # else if( x > arr[mid])  branch to L2
    j       L3                      # else  branch to L3

L1:                                 # if x == arr[mid]
    add     $t2, $zero, $t5         #index of x = mid  
    addi    $t1, $t5, -1            #  j = mid - 1
    j       while                   # go to while loop again


L2:                                 # if x > arr[mid]
    addi    $t0, $t5, 1             # i = mid + 1
    j       while                   # go to while loop again

L3:                                 # if x < arr[mid]
    addi    $t1, $t5, -1            #  j = j - 1
    j       while                   # go to while loop again


print_1:                           # after exiting the while loop
    addi    $t0,$zero,-1           # t0 = -1  
    beq     $t2, $t0, No_ind       # if t2 == -1, i.e, x is not found 
    li      $v0, 4                 # else  print "Yes at index : " as x is present in the array
    la      $a0, msg5
    syscall
    li      $v0, 1                 # print the index using syscall 1
    move    $a0, $t2               # 
    syscall
    j       end
No_ind:                           # value Search is not found in the array so printing the corresponding message to be displayed
    li      $v0, 4
    la      $a0, msg4
    syscall

end:                              #exit syscall
    li      $v0, 10
    syscall


.data     
heap_pointer:  .word 0
msg1:          .asciiz "Enter the number of elements\n"
msg2:          .asciiz "Enter the numbers\n"
msg3:          .asciiz " Enter the value to Search\n"
msg4:          .asciiz "Not found\n"
msg5:          .asciiz "Yes at index : \n"


# AssumptionS:
#1) array is sorted
#2) No of maximum elements in the array is 30
#3) integer size does not exceeds 32 bits

