# File:		solve_puzzle.asm
# Author:	P. Salts
#
# Description:	TODO

PRINT_INT = 1

# CONSTANTS
# other stuff
GRASS = 46
TENT = 65
TREE = 84
MAX_SIZE = 12

# DATA
	.data
	.globl	board_size
	.globl	row_sums
	.globl	col_sums
	.globl	board

# CODE
	.text
	.align	2

# EXTERNAL CODE
	.globl	solve_puzzle

#
# Name:		solve_puzzle
#
# Description:	Solves the puzzle.
#

solve_puzzle:
	addi	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)

	j	check_board

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12

	jr	$ra

#
# Name:		check_board
#

check_board:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	jal	check_rows

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

#
# Name:		check_rows
#

check_rows:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	move	$v0, $zero

	la	$t0, board_size
	lw	$t0, 0($t0)
	la	$t1, row_sums
	la	$t3, board
	move	$t5, $zero	#which row to look at, y
	li	$t7, TENT
	li	$t8, MAX_SIZE

checkr_loopy_start:
	slt	$t9, $t5, $t0
	beq	$t9, $zero, checkr_loopy_end
	move	$t4, $zero	#sum of tents in row
	move	$t6, $zero	#which element in the row, x
checkr_loopx_start:
	slt	$t9, $t6, $t0
	beq	$t9, $zero, checkr_loopx_end
	mul	$t2, $t5, $t8
	add	$t2, $t2, $t6
	add	$t2, $t2, $t3
	lbu	$t2, 0($t2)
	bne	$t2, $t7, checkr_skip_add
	addi	$t4, $t4, 1
checkr_skip_add:
	addi	$t6, $t6, 1
	j	checkr_loopx_start
checkr_loopx_end:
	
checkr_loopy_end:

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra

#
# Name:		check_cols
#

check_cols:

#
# Name:		check_visibility
#

check_visibility:
