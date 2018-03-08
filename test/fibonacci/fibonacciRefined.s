.global __start     # export start symbol
.text

__start:            # define entry point for gcc

li 		$sp, 0x7ffffffc

# nop for pipeline test
nop
nop
nop
nop
nop

li 		$a0, 10 # this number represents the nth fibonacci number - e.g. f(10) = 55
nop			#upon compile, the nop will follow the jal to fill the branch delay slot.

# nop for pipeline test
nop
nop
nop
nop
nop

jal 	fibonacci

# nop for pipeline test
nop
nop
nop
nop
nop

# print the value
add	$a0, $v0, $zero #Move fibonacci's return value to the argument.

# nop for pipeline test
nop
nop
nop
nop
nop

li	$v0, 1		# set for print integer syscall.

# nop for pipeline test
nop
nop
nop
nop
nop

syscall

# nop for pipeline test
nop
nop
nop
nop
nop

# end the program
li 		$v0, 10

# nop for pipeline test
nop
nop
nop
nop
nop

syscall

# nop for pipeline test
nop
nop
nop
nop
nop

fibonacci:
	addi 	$sp, $sp, -12

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	sw		$ra, 8($sp)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	sw		$s0, 4($sp)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	sw		$s1, 0($sp)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	add 	$s0, $a0, $zero

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	li 		$v0, 1 			# return the value of base case

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	li 		$t2, 3

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	li 		$t3, 1

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	slt 	$t4, $s0, $t2  	# base case

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	beq 	$t4, $t3, fibonacciTerminate

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	nop			#compile automatically adds nop after beq, so this is probably extraneous

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	addi 	$a0, $s0, -1 	# fibonacci(n-1)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	nop			#nop again, because of the compile.

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	jal 	fibonacci

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	add 	$s1, $v0, $zero   # store result of fibonacci(n-1) to s1

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	addi 	$a0, $s0, -2 	# fibonacci(n-2)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	nop

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	jal 	fibonacci

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	add 	$v0, $s1, $v0 	# fibonacci(n-1) + fibonacci(n-2)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

fibonacciTerminate:
	lw 		$ra, 8($sp)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	lw 		$s0, 4($sp)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	lw 		$s1, 0($sp)

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	addi	$sp, $sp, 12

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	nop

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop

	jr 		$ra

	# nop for pipeline test
	nop
	nop
	nop
	nop
	nop
