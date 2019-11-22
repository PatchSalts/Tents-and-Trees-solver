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

# STRINGS/CHARS
top_bot_start:
	.asciiz	"+-"
top_bot_mid:
	.asciiz	"--"
top_bot_end:
	.asciiz	"+\n"
pipe:
	.asciiz	"| "
space:
	.asciiz	" "
new_line_char:
	.asciiz	"\n"

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
	sw	$ra, 0($sp)

	move	$t0, $zero	# $t0 = col (x) = 0
	move	$t1, $zero	# $t1 = row (y) = 0
	li	$t5, MAX_SIZE	# $t5 = MAX_SIZE
	la	$t6, board_size	# $t6 = board_size
	lw	$t6, 0($t6)
	la	$t7, row_sums	# $t7 = row_sums
	la	$t8, col_sums	# $t8 = col_sums
	la	$t9, board	# $t9 = board

	li	$v0, PRINT_STRING
	la	$a0, top_bot_start
	syscall
	move	$t2, $zero
loop_top_start:
	slt	$t3, $t2, $t6
	beq	$t3, $zero, loop_top_end
	li	$v0, PRINT_STRING
	la	$a0, top_bot_mid
	syscall
	addi	$t2, $t2, 1
	j	loop_top_start
loop_top_end:
	li	$v0, PRINT_STRING
	la	$a0, top_bot_end
	syscall

loop_row_start:
	slt	$t2, $t1, $t6
	beq	$t2, $zero, loop_row_end
	li	$v0, PRINT_STRING
	la	$a0, pipe
	syscall

loop_col_start:
	slt	$t2, $t0, $t6
	beq	$t2, $zero, loop_col_end

	mul	$t2, $t1, $t5
	add	$t2, $t2, $t0
	add	$t2, $t2, $t9
	li	$v0, PRINT_CHAR
	lbu	$a0, 0($t2)
	syscall
	li	$v0, PRINT_STRING
	la	$a0, space
	syscall

	addi	$t0, $t0, 1
	j	loop_col_start
loop_col_end:
	li	$v0, PRINT_STRING
	la	$a0, pipe
	syscall
	li	$t2, 4
	mul	$t2, $t1, $t2
	add	$t2, $t2, $t7
	lw	$t2, 0($t2)
	li	$v0, PRINT_INT
	move	$a0, $t2
	syscall

	move	$t0, $zero
	addi	$t1, $t1, 1
	li	$v0, PRINT_STRING
	la	$a0, new_line_char
	syscall
	j	loop_row_start
loop_row_end:

	li	$v0, PRINT_STRING
	la	$a0, top_bot_start
	syscall
	move	$t2, $zero
loop_bot_start:
	slt	$t3, $t2, $t6
	beq	$t3, $zero, loop_bot_end
	li	$v0, PRINT_STRING
	la	$a0, top_bot_mid
	syscall
	addi	$t2, $t2, 1
	j	loop_bot_start
loop_bot_end:
	li	$v0, PRINT_STRING
	la	$a0, top_bot_end
	syscall

	li	$v0, PRINT_STRING
	la	$a0, space
	syscall
	syscall
	move	$t2, $zero
loop_col_sums_start:
	slt	$t3, $t2, $t6
	beq	$t3, $zero, loop_col_sums_end
	li	$t4, 4
	mul	$t4, $t1, $t4
	add	$t4, $t4, $t8
	lw	$t4, 0($t4)
	li	$v0, PRINT_INT
	move	$a0, $t4
	syscall
	li	$v0, PRINT_STRING
	la	$a0, space
	syscall
	addi	$t2, 1
	j	loop_col_sums_start
loop_col_sums_end:
	li	$v0, PRINT_STRING
	la	$a0, new_line_char
	syscall
	syscall

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4

	jr	$ra
