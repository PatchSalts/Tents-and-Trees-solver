# File:		read_puzzle.asm
# Author:	P. Salts
#
# Description:	This program reads in a board from standard input,
#		placing the results in memory spaces provided by tents.asm

# CONSTANTS
#
# syscall codes
PRINT_STRING = 4
READ_INT = 5
EXIT = 10
READ_CHAR = 12
# other stuff
MIN_SIZE = 2
MAX_SIZE = 12
GRASS = 46
ZERO = 48
TREE = 84

# EXTERNAL MEMORY SPACES
	.globl	board_size
	.globl	row_sums
	.globl	col_sums
	.globl	board

	.data
# ERROR MESSAGES
invalid_size:
	.asciiz	"Invalid board size, Tents terminating\n"
invalid_sum:
	.asciiz	"Illegal sum value, Tents terminating\n"
invalid_char:
	.asciiz	"Illegal board character, Tents terminating\n"

# CODE
	.text
	.align	2

# EXTERNAL CODE
	.globl	read_puzzle

#
# Name:		read_puzzle
#
# Description:	Main logic for the program.
#
#	This function reads in the values and the board,
#	placing them in the correct memory areas to be used by the main program.
#

read_puzzle:
	addi	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)

	li	$v0, READ_INT
	syscall			# read board size
	li	$t9, MAX_SIZE
	addi	$t9, $t9, 1
	slt	$t9, $v0, $t9
	beq	$t9, $zero, size_error
	li	$t9, MIN_SIZE
	slt	$t9, $v0, $t9
	bne	$t9, $zero, size_error
	la	$t0, board_size
	sw	$v0, 0($t0)	# store board size

	move	$s0, $v0	# store board size for repeated calling

	move	$a0, $s0	# prepare row args
	la	$a1, row_sums
	jal	read_sums

	move	$a0, $s0	# prepare col args
	la	$a1, col_sums
	jal	read_sums

	move	$a0, $s0	# prepare board args
	la	$a1, board
	jal	read_board

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	addi	$sp, $sp, 8

	jr	$ra

#
# Name:		read_sums
#
# Description:	Reads a specified number of char numbers from standard input.
#
# Arguments:	a0	the number of characters to read
#		a1	the address of the first sum to store
#
#	This function reads sum characters from standard input,
#	calculates their value, and stores them in the correct memory area.
#

read_sums:
	addi	$t9, $a0, 1
	li	$t8, 2
	div	$t9, $t8
	mflo	$t9
	addi	$t9, $t9, 1
loop_readnums_start:
	beq	$a0, $zero, loop_readnums_end
	li	$v0, READ_CHAR
	syscall			# read character
	addi	$v0, $v0, -ZERO	# convert to number
	slt	$t8, $v0, $t9
	beq	$t8, $zero, sum_error
	slt	$t8, $v0, $zero
	bne	$t8, $zero, sum_error
	sw	$v0, 0($a1)	# store number
	addi	$a0, $a0, -1
	addi	$a1, $a1, 4
	j	loop_readnums_start
loop_readnums_end:

	li	$v0, READ_CHAR
	syscall			# trim newline

	jr	$ra

#
# Name:		read_board
#
# Description:	Reads a the tree board from standard input.
#
# Arguments:	a0	the board size
#		a1	the address of the first space on the board
#
#	This function reads tree characters and places them in memory.
#

read_board:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	move	$t0, $zero	# $t0 = col (x) = 0
	move	$t1, $zero	# $t1 = row (y) = 0
	li	$t9, MAX_SIZE	# $t9 = MAX_SIZE

loop_rows_start:
	slt	$t8, $t1, $a0
	beq	$t8, $zero, loop_rows_end
loop_cols_start:
	slt	$t8, $t0, $a0
	beq	$t8, $zero, loop_cols_end
	li	$v0, READ_CHAR
	syscall
	j	check_char
good_char:
	mul	$t8, $t1, $t9
	add	$t8, $t8, $t0
	add	$t8, $t8, $a1	# $t8 = place to put char
	sb	$v0, 0($t8)
	addi	$t0, $t0, 1
	j	loop_cols_start
loop_cols_end:
	move	$t0, $zero
	addi	$t1, $t1, 1
	li	$v0, READ_CHAR	#trim newline
	syscall
	j	loop_rows_start
loop_rows_end:

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

	jr	$ra

check_char:
	li	$t6, GRASS
	li	$t7, TREE
	beq	$v0, $t6, good_char
	beq	$v0, $t7, good_char
	j	char_error

#
# The following functions just print error messages and exit.
#

size_error:
	li	$v0, PRINT_STRING
	la	$a0, invalid_size
	syscall
	li	$v0, EXIT
	syscall

sum_error:
	li	$v0, PRINT_STRING
	la	$a0, invalid_sum
	syscall
	li	$v0, EXIT
	syscall

char_error:
	li	$v0, PRINT_STRING
	la	$a0, invalid_char
	syscall
	li	$v0, EXIT
	syscall

