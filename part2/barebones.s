# Build an executable using the following:
#
# clang barebones.s -o barebones  # clang is another compiler like gcc
#
.text
_barebones:

.data

.globl main

main:
					# (1) What are we setting up here?
					# Ans:
	pushq %rbp			# pushing register rbp to the stack
	movq  %rsp, %rbp		#moving	data in rsp to rbp

					# (2) What is going on here
					# Ans:
	movq $1, %rax			# moving the literal int 1 into rax
	movq $1, %rdi			# moving the literal int 1 into rdi
	leaq .hello.str,%rsi		# load the address of .hello.str directive into rsi


					# (3) What is syscall? We did not talk about this
					# in class.
					# Ans: A syscall is a call to a function that's builtin to the OS
	syscall				# Which syscall is being run?
					# Ans: A memory management system call like malloc()

					# (4) What would another option be instead of
					# using a syscall to achieve this?
					# Ans: moving the value into a register

	movq	$60, %rax		# (5) We are again setting up another syscall
	movq	$0, %rdi		# What command is it?
					# Ans: A memory management system call like free()
	syscall

	popq %rbp			# (Note we do not really need
					# this command here after the syscall)

.hello.str:
	.string "Hello World!\n"
	.size	.hello.str,13		# (6) Why is there a 13 here?
					# Ans: because the string "Hello World!" is of size 13 (elements) including the newline.