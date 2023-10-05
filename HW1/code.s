 .data
number1: .word 0x40b40000
number2: .word 0x405d0000
sign_mask: .word 0x80000000
exp_mask:  .word 0x7f800000
man_mask:  .word 0x007fffff
add_int: .word 0x00000080
norm_mask: .word 0x00008000

valueis: .string "value is:"
nextline: .string "\n"
NaN: .string "NaN"
    
.text
main:
    #s0 = number1
    #s1 = number2
    #s2 = sign_mask
    #s3 = exp_mask
    #s4 = man_mask
    #s5 = output
   
    la s0 number1
    lw s0 0(s0) 
    la s1 number2
    lw s1 0(s1)
    la s2 sign_mask
    lw s2 0(s2)
 
    
    xor t2 s0 s1
    and s10 t2 s2  # get sign
    
    la s2 exp_mask
    lw s2 0(s2)
    and t3 s0 s2
    and t4 s1 s2
    srli t3 t3 23
    srli t4 t4 23
    addi t3 t3 -127 
    addi t4 t4 -127
     
    
    add t3 t3 t4  
    addi s11 t3 127 # get exponent
    
    
    la s3 man_mask
    lw s3 0(s3)
    la s4 add_int
    lw s4 0(s4)
    #t3 = multiplicand
    #t4 = multiplier
    #t5 = product
    and t3 s0 s3
    and t4 s1 s3
    srli t3 t3 16
    srli t4 t4 16
    or t3 t3 s4
    or t4 t4 s4
 
    mv s9 t3
    mv t5 x0
    mv s7 x0
    mv s8 x0
    addi s8 s8 8
 
    andi t6 t4 1   # t6 = last_bit
    srli t4 t4 1   #right shift multiplier 1 bit 
    beqz t6 loop
    add t5 s9 t5
loop:
    slli t3 t3 1   #left shift multiplicand 1 bit
    bge s7 s8 normalize
    addi s7 s7 1
    andi t6 t4 1   # t6 = last_bit
    srli t4 t4 1   #right shift multiplier 1 bit 
    #slli t3 t3 1   #left shift multiplicand 1 bit
    beqz t6, loop
    add t5 t3 t5
    j loop

normalize:  
    la s0 norm_mask
    lw s0 0(s0)
    and s0 s0 t5 #if mantissa need to carry
    beqz s0 bits_15
    addi s11 s11 1
    slli s11 s11 24 #have to cut the integer meanwhile
    srli s11 s11 1
    srli t5 t5 7 # discard unnecessary digits
    slli t5 t5 24 # after carring one bit,only have to shift left 24 bits
    srli t5 t5 9 #corresponding to the position of the mantissa
    j combine
bits_15:
    slli s11 s11 24
    srli s11 s11 1
    srli t5 t5 7 # discard unnecessary digits
    slli t5 t5 25 
    srli t5 t5 9
combine:   
    or s10 s11 s10 #combine sign and exponent
    or s10 s10 t5
    
#/........................../ 
  
#beq t3 0x7f800000 nan #if exponent >=11111111 print NaN 
#nan:
    #la a0 NaN
    #li a7,4
    #ecall
    #j end
#/........................../  

   
    
print_number:
    # t0 : valueis
    # t1 : \n
    la t0 valueis
    mv a0 t0
    li a7,4
    ecall
    mv a0, s10
    li a7,34
    ecall
    la t1, nextline
    mv a0, t1
    li a7,4
    ecall

end:
    add x0 x0 x0
   