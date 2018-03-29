# This test program loads two immediate values
# and prints the sum using a syscall.

.global __start		# export start symbol
.text

.data
     str1: .asciiz    “A”
     str2: .asciiz    “Hello”
.globl main
main:
    lui $a0, $str2
    addi $v0, $0, 4
    syscall
