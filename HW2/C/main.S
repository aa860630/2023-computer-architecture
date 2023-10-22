	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	count_leading_zeros
	.type	count_leading_zeros, @function
count_leading_zeros:
	slli	a4,a1,31
	srli	a5,a0,1
	or	a5,a4,a5
	srli	a4,a1,1
	or	a1,a4,a1
	or	a0,a5,a0
	slli	a4,a1,30
	srli	a5,a0,2
	or	a5,a4,a5
	srli	a4,a1,2
	or	a4,a4,a1
	or	a0,a5,a0
	slli	a3,a4,28
	srli	a5,a0,4
	or	a5,a3,a5
	srli	a3,a4,4
	or	a3,a3,a4
	or	a4,a5,a0
	slli	a2,a3,24
	srli	a5,a4,8
	or	a5,a2,a5
	srli	a2,a3,8
	or	a2,a2,a3
	or	a5,a5,a4
	srli	a3,a5,16
	slli	a4,a2,16
	or	a3,a4,a3
	srli	a4,a2,16
	or	a4,a4,a2
	or	a3,a3,a5
	or	a3,a4,a3
	slli	a1,a4,31
	srli	a5,a3,1
	li	a2,1431654400
	addi	a2,a2,1365
	or	a5,a1,a5
	and	a5,a5,a2
	srli	a1,a4,1
	sub	a5,a3,a5
	and	a2,a1,a2
	sgtu	a3,a5,a3
	sub	a4,a4,a2
	sub	a4,a4,a3
	slli	a1,a4,30
	srli	a3,a5,2
	li	a2,858992640
	addi	a2,a2,819
	or	a3,a1,a3
	and	a3,a3,a2
	srli	a1,a4,2
	and	a5,a5,a2
	add	a5,a3,a5
	and	a1,a1,a2
	and	a4,a4,a2
	add	a4,a1,a4
	sltu	a3,a5,a3
	add	a3,a3,a4
	slli	a2,a3,28
	srli	a4,a5,4
	or	a4,a2,a4
	add	a5,a4,a5
	srli	a2,a3,4
	add	a2,a2,a3
	sltu	a4,a5,a4
	li	a3,252645376
	addi	a3,a3,-241
	add	a4,a4,a2
	and	a4,a4,a3
	and	a5,a5,a3
	slli	a2,a4,24
	srli	a3,a5,8
	or	a3,a2,a3
	add	a5,a3,a5
	srli	a2,a4,8
	add	a4,a2,a4
	sltu	a3,a5,a3
	add	a3,a3,a4
	slli	a2,a3,16
	srli	a4,a5,16
	or	a4,a2,a4
	add	a5,a4,a5
	srli	a2,a3,16
	sltu	a4,a5,a4
	add	a3,a2,a3
	add	a4,a4,a3
	add	a4,a4,a5
	andi	a4,a4,127
	li	a0,64
	sub	a0,a0,a4
	slli	a0,a0,16
	srli	a0,a0,16
	ret
	.size	count_leading_zeros, .-count_leading_zeros
	.align	2
	.globl	predict_if_mul_overflow
	.type	predict_if_mul_overflow, @function
predict_if_mul_overflow:
	addi	sp,sp,-16
	sw	s1,4(sp)
	mv	s1,a1
	lw	a1,4(a0)
	lw	a0,0(a0)
	sw	ra,12(sp)
	sw	s0,8(sp)
	call	count_leading_zeros
	lw	a1,4(s1)
	mv	s0,a0
	lw	a0,0(s1)
	call	count_leading_zeros
	li	a5,64
	sub	s0,a5,s0
	sub	a5,a5,a0
	add	s0,s0,a5
	lw	ra,12(sp)
	slti	a0,s0,64
	lw	s0,8(sp)
	lw	s1,4(sp)
	xori	a0,a0,1
	addi	sp,sp,16
	jr	ra
	.size	predict_if_mul_overflow, .-predict_if_mul_overflow
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"%d\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a1,%hi(a_x1)
	lui	a0,%hi(a_x0)
	addi	sp,sp,-16
	addi	a1,a1,%lo(a_x1)
	addi	a0,a0,%lo(a_x0)
	sw	ra,12(sp)
	sw	s0,8(sp)
	call	predict_if_mul_overflow
	lui	s0,%hi(.LC0)
	mv	a1,a0
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a1,%hi(b_x1)
	lui	a0,%hi(b_x0)
	addi	a1,a1,%lo(b_x1)
	addi	a0,a0,%lo(b_x0)
	call	predict_if_mul_overflow
	mv	a1,a0
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a1,%hi(c_x1)
	lui	a0,%hi(c_x0)
	addi	a1,a1,%lo(c_x1)
	addi	a0,a0,%lo(c_x0)
	call	predict_if_mul_overflow
	mv	a1,a0
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a1,%hi(d_x1)
	lui	a0,%hi(d_x0)
	addi	a1,a1,%lo(d_x1)
	addi	a0,a0,%lo(d_x0)
	call	predict_if_mul_overflow
	mv	a1,a0
	addi	a0,s0,%lo(.LC0)
	lw	s0,8(sp)
	lw	ra,12(sp)
	addi	sp,sp,16
	tail	printf
	.size	main, .-main
	.globl	d_x1
	.globl	d_x0
	.globl	c_x1
	.globl	c_x0
	.globl	b_x1
	.globl	b_x0
	.globl	a_x1
	.globl	a_x0
	.section	.sbss,"aw",@nobits
	.align	3
	.type	a_x1, @object
	.size	a_x1, 8
a_x1:
	.zero	8
	.type	a_x0, @object
	.size	a_x0, 8
a_x0:
	.zero	8
	.section	.sdata,"aw"
	.align	3
	.type	d_x1, @object
	.size	d_x1, 8
d_x1:
	.word	-1
	.word	2147483647
	.type	d_x0, @object
	.size	d_x0, 8
d_x0:
	.word	3
	.word	0
	.type	c_x1, @object
	.size	c_x1, 8
c_x1:
	.word	0
	.word	1073741824
	.type	c_x0, @object
	.size	c_x0, 8
c_x0:
	.word	2
	.word	0
	.type	b_x1, @object
	.size	b_x1, 8
b_x1:
	.word	16
	.word	0
	.type	b_x0, @object
	.size	b_x0, 8
b_x0:
	.word	1
	.word	0
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 13.2.0"
