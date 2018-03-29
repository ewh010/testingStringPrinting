# This test program loads two immediate values
# and prints the sum using a syscall.

.data
     str: .asciiz    “Hello”
     
.text
main:

    la $a0, $str
    li $v0, 4
    syscall

    li $v0, 10
    syscall
