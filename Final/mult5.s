    .data
input_buffer:   .word 0
prompt_msg:     .asciz "Enter an integer (-1 to quit): "
format_in:      .asciz "%d"
out_total:      .asciz "\nTotal values entered: %d\n"
out_count5:     .asciz "Number of multiples of 5: %d\n"
out_sum5:       .asciz "Sum of multiples of 5: %d\n"

    .text
    .global main

main:
    @ Allocate 24 bytes on stack
    SUB sp, sp, #24             
    STR lr, [sp, #20]           
    STR r4, [sp, #16]           
    STR r5, [sp, #12]           
    STR r6, [sp, #8]            
    STR r7, [sp, #4]            

    MOV r4, #0                  @ total_values = 0
    MOV r5, #0                  @ mult5_count = 0
    MOV r6, #0                  @ sum_mult5 = 0

loop:
    LDR r0, =prompt_msg
    BL printf

    LDR r0, =format_in
    LDR r1, =input_buffer
    BL scanf

    LDR r1, =input_buffer
    LDR r7, [r1]                @ r7 = input_val

    CMP r7, #-1                 @ Check for -1 (sentinel value)
    BEQ end_loop

    ADD r4, r4, #1              @ total_values++

    @ repeated subtraction
    MOV r1, r7                  @ Copy input_val to r1 for manipulation
    
    @ Handle negative numbers to ensure loop doesn't break
    CMP r1, #0
    BGE mod5_loop               @ If positive or zero, skip to loop
    RSB r1, r1, #0              @ Reverse Subtract: r1 = 0 - r1 (Absolute value)

mod5_loop:
    CMP r1, #5                  @ Compare current value with 5
    BLT mod5_done               @ If less than 5, we are done subtracting
    SUB r1, r1, #5              @ Subtract 5
    B mod5_loop                 @ Repeat

mod5_done:
    CMP r1, #0                  @ Is the final remainder exactly 0?
    BNE skip_multiple           @ If not, it's not a multiple of 5

    @ It IS a multiple of 5
    ADD r5, r5, #1              @ mult5_count++
    ADD r6, r6, r7              @ sum_mult5 += input_val (add original r7)

skip_multiple:
    B loop                      

end_loop:
    LDR r0, =out_total
    MOV r1, r4
    BL printf
    
    LDR r0, =out_count5
    MOV r1, r5
    BL printf
    
    LDR r0, =out_sum5
    MOV r1, r6
    BL printf

    MOV r0, #0                  @ Return code 0

    @ Restore registers manually
    LDR lr, [sp, #20]           
    LDR r4, [sp, #16]           
    LDR r5, [sp, #12]           
    LDR r6, [sp, #8]            
    LDR r7, [sp, #4]            
    ADD sp, sp, #24             @ Deallocate stack

    BX lr