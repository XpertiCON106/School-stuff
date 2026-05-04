.data
prompt_msg:     .asciz "Enter an integer (-1 to quit): "
format_in:      .asciz "%d"
out_total:      .asciz "\nTotal values entered: %d\n"
out_count5:     .asciz "Number of multiples of 5: %d\n"
out_sum5:       .asciz "Sum of multiples of 5: %d\n"

    .balign 4
input_buffer:   .word 0

    .text
    .global main
    .func main

main:
    SUB sp, sp, #24             @ Allocate 24 bytes on stack (maintains 8-byte alignment)
    STR lr, [sp, #20]           @ Save Link Register
    STR r4, [sp, #16]           @ Save R4 (total_values)
    STR r5, [sp, #12]           @ Save R5 (mult5_count)
    STR r6, [sp, #8]            @ Save R6 (sum_mult5)
    STR r7, [sp, #4]            @ Save R7 (input_val)

    MOV r4, #0                  @ total_values = 0
    MOV r5, #0                  @ mult5_count = 0
    MOV r6, #0                  @ sum_mult5 = 0

loop:
    @ Prompt the user
    LDR r0, =prompt_msg
    BL printf

    @ Read integer input
    LDR r0, =format_in
    LDR r1, =input_buffer
    BL scanf

    @ Load the read value into R7
    LDR r1, =input_buffer
    LDR r7, [r1]

    @ Check for sentinel value (-1)
    CMP r7, #-1
    BEQ end_loop

    @ Increment total values counter
    ADD r4, r4, #1

    @ Check if multiple of 5 (input % 5 == 0)
    MOV r1, r7                  @ r1 = input_val
    MOV r2, #5                  @ r2 = 5
    SDIV r0, r1, r2             @ r0 = input_val / 5
    MLS r3, r0, r2, r1          @ r3 = input_val - (r0 * 5) -> r3 is the remainder

    CMP r3, #0                  @ Check if remainder is 0
    BNE skip_multiple           @ If not 0, it's not a multiple of 5. Skip.

    @ It IS a multiple of 5. Update counts.
    ADD r5, r5, #1
    ADD r6, r6, r7              @ sum_mult5 = sum_mult5 + input_val

skip_multiple:
    B loop                      @ Branch back to the start of the loop

end_loop: 
    @ Print Total Values
    LDR r0, =out_total
    MOV r1, r4
    BL printf
    
    @ Print Count of Multiples of 5
    LDR r0, =out_count5
    MOV r1, r5
    BL printf
    
    @ Print Sum of Multiples of 5
    LDR r0, =out_sum5
    MOV r1, r6
    BL printf

    MOV r0, #0

    @ Restoring stack and return
    LDR lr, [sp, #20]
    LDR r4, [sp, #16]
    LDR r5, [sp, #12]
    LDR r6, [sp, #8]
    LDR r7, [sp, #4]
    ADD sp, sp, #24

    BX lr
    .endfunc