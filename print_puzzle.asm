# File:		print_puzzle.asm
# Author:	P. Salts
#
# Description:	This program prints a tents board game.

# CONSTANTS
#
# syscall codes
PRINT_INT = 1
PRINT_STRING = 4
EXIT = 10
PRINT_CHAR = 11
# other stuff
MAX_SIZE = 12

# DATA
	.data
	.align	2

	.globl	board_size
	.globl	row_sums
	.globl	col_sums
	.globl	board

# STRINGS
top_bot_line:
	.asciiz	"+-------------+\n"

# CODE
	.text
	.align	2

# EXTERNAL CODE
	.globl	print_puzzle

#
# Name:		print_puzzle
#
# Description:	This function prints just the board.
#

print_puzzle:
	addi	$sp, $sp, -4
	sw	$ra, 0($p)

	la	

	li	$v0, PRINT_STRING
	la	$a0, top_bot_line
	syscall

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

	jr	$ra
