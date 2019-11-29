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

	move	$v0, $zero
	jal	check_rows

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12

	jr	$ra

#
# Name:		check_rows
#

check_rows:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

#setup
	move	$t0, $zero
	move	$t1, $zero
	la	$t2, board_size
	lw	$t2, 0($t2)
	la	$t3, board
	li	$t5, MAX_SIZE
	li	$t7, TREE
	la	$t8, row_sums
loop_y_start:
	slt	$t4, $t1, $t2
	beq	$zero, $t4, loop_y_end
	move	$t6, $zero
loop_x_start:
	slt	$t4, $t0, $t2
	beq	$zero, $t4, loop_x_end
	mul	$t4, $t1, $t5
	add	$t4, $t4, $t0
	add	$t4, $t3, $t3

	lbu	$t4, 0($t4)
	bne	$t4, 
	addi	$t6, $t6, 1
skip_add_sum_r:

	addi	$t0, $t0, 1
	j	loop_x_start
loop_x_end:

	add	$t4, $t8, $t1
	lw	$t4, 0($t4)
	beq	$t4, $t7, skip_fail
	li	$v0, 1
skip_fail:

	move	$t0, $zero
	addi	$t1, $t1, 1
	j	loop_y_start
loop_y_end:

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

	jr	$ra
