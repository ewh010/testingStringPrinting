# This test program loads two immediate values
# and prints the sum using a syscall.

.global __start		# export start symbol
.text

__start:	        # define entry point for gcc
nop
nop
nop
nop
nop
li $t0, 1
nop
nop
nop
nop
li $t1, 2
nop
nop
nop
nop

li $v0, 1		# setup for print integer syscall
nop
nop
nop
nop
add $a0, $t1, $t0	# syscall prints value in a0
nop
nop
nop
nop
syscall
nop
nop
nop
nop

li $v0, 10 		# exit syscall
nop
nop
nop
nop
syscall
nop
nop
nop
nop
