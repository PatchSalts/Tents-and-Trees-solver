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
#	This program reads in the values and the board,
#	placing them
#

read_puzzle:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	li	$v0, READ_INT	# read board size
	syscall
	mv	$s0, $v0
	la	$t0, board_size
	sw	$v0, 0($t0)	# store board size

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

	jr	$ra
