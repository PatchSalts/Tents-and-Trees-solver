# File:		tents.asm
# Author:	P. Salts
#
# Description:	This program solves a game of tents.
#		It reads in a board and then does [rec/iter] backtracking in
#		order to solve it based on the rules.
#		Rules can be found at http://www.brainbashers.com/tents.asp

# CONSTANTS
#
# syscall codes
PRINT_INT = 1
PRINT_STRING = 4
READ_INT = 5
EXIT = 10
# other stuff
MAX_SIZE = 12

# DATA
	.data
	.align	2

board_size:
	.space	1*4
row_sums:
	.space	MAX_SIZE*4
col_sums:
	.space	MAX_SIZE*4
board:
	.space	MAX_SIZE*MAX_SIZE

	.globl	board_size
	.globl	row_sums
	.globl	col_sums
	.globl	board

# STRINGS
blank_line:
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

	jal	read_puzzle

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

	jr	$ra
