# File:		print_puzzle.asm
# Author:	P. Salts
#
# Description:	This program prints a tents board game.

# CONSTANTS
#
# syscall codes
PRINT_INT = 1
PRINT_STRING = 4
READ_INT = 5
EXIT = 10
# other stuff
MIN_SIZE = 2
MAX_SIZE = 12

# DATA
	.data
	.align	2

board_size:			# 1 int
	.space	1*4
row_sums:			# MAX_SIZE ints
	.space	MAX_SIZE*4
col_sums:			# MAX_SIZE ints
	.space	MAX_SIZE*4
board:				# MAX_SIZE^2 chars
	.space	MAX_SIZE*MAX_SIZE

	.globl	board_size
	.globl	row_sums
	.globl	col_sums
	.globl	board

# STRINGS
new_line:
	.asciiz	"\n"
asterisks:
	.asciiz	"******************\n"
title:
	.asciiz	"**     TENTS    **\n"
init_puzz_mess:
	.asciiz	"Initial Puzzle\n"
fin_puzz_mess:
	.asciiz	"Final Puzzle\n"
imp_puzz_mess:
	.asciiz	"Impossible Puzzle\n"

# CODE
	.text
	.align	2

# EXTERNAL CODE
	.globl	read_puzzle

#
# Name:		MAIN PROGRAM
#
# Description:	Main logic for the program.
#
#	This program reads in the values and the board,
#	prints the input board,
#	runs a DFS-like algorithm (with backtracking) to find a valid solution,
#	then prints out the completed board.
#

main:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	jal	print_header
	jal	read_puzzle

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

	jr	$ra

#
# Name:		print_header
#
# Description:	Prints the header.
#
#	This function prints the header.
#	Please don't make me explain any more than that.
#

print_header:
	li	$v0, PRINT_STRING
	la	$a0, new_line
	syscall
	la	$a0, asterisks
	syscall
	la	$a0, title
	syscall
	la	$a0, asterisks
	syscall
	la	$a0, new_line
	syscall

	jr	$ra
