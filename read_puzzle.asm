# File:		read_puzzle.asm
# Author:	P. Salts
#
# Description:	This program reads in a board from standard input,
#		placing the results in memory spaces provided by tents.asm

# CONSTANTS
#
# syscall codes
READ_INT = 5
EXIT = 10
READ_CHAR = 12
# other stuff
MAX_SIZE = 12
ZERO = 48

# EXTERNAL MEMORY SPACES
	.globl	board_size
	.globl	row_sums
	.globl	col_sums
	.globl	board

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
	la	$t0, board_size
	sw	$v0, 0($t0)	# store board size

	move	$s0, $v0	# store board size for repeated calling

	move	$a0, $s0	# prepare row args
	la	$a1, row_sums
	jal	read_sums

	move	$a0, $s0	# prepare col args
	la	$a1, col_sums
	jal	read_sums

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	addi	$sp, $sp, 8

	jr	$ra

#
# Name:		read_sums
#
# Description:	Reads a specified number of characters from standard input.
#
# Arguments:	a0	the number of characters to read
#		a1	the address of the first sum to store
#
#	This function reads sum characters from standard input,
#	calculates their value, and stores them in the correct memory area.
#

read_sums:

loop_readnums_start:
	beq	$a0, $zero, loop_readnums_end
	li	$v0, READ_CHAR
	syscall			# read character
	addi	$v0, $v0, -ZERO	# convert to number
	sw	$v0, 0($a1)	# store number
	addi	$a0, $a0, -1
	addi	$a1, $a1, 4
	j	loop_readnums_start
loop_readnums_end:

	li	$v0, READ_CHAR
	syscall			# trim newline

	jr	$ra
