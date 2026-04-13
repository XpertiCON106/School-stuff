// EN605
// Module 11 Assignment
// Tahalil I Morsilin
// 04/12/2026

.data
prompt_m:   .asciz "Enter the multiplier (m): "
prompt_n:   .asciz "Enter the number of additions (n): "
format_in:  .asciz "%d"
result_out: .asciz "Result: %d\n"

m_val:      .word 0
n_val:      .word 0

.text
.global main

// Problem 1: Recursive multiplication
Mult:
    SUB sp, sp, #16
    STR lr, [sp]            // save lr
    STR r4, [sp, #4]        // save r4
    STR r5, [sp, #8]        // save r5

    MOV r4, r0              // r4 = m
    MOV r5, r1              // r5 = n

    // if (n == 1) return m
    CMP r5, #1
    BNE Mult_Else
    MOV r0, r4
    B Mult_Return           // branch

Mult_Else:
    SUB r1, r5, #1          // n - 1
    MOV r0, r4              // m
    BL Mult                 // this is our recursive call
    
    // Add m to the result of Mult(m, n-1)
    ADD r0, r4, r0          // m + Mult(m, n-1)
    B Mult_Return

// restores
Mult_Return:
    LDR lr, [sp]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #16
    MOV pc, lr              // return to caller

main:
    SUB sp, sp, #8
    STR lr, [sp]

    // prompt for m
    LDR r0, =prompt_m
    BL printf
    LDR r0, =format_in
    LDR r1, =m_val
    BL scanf

    // prompt for n
    LDR r0, =prompt_n
    BL printf
    LDR r0, =format_in
    LDR r1, =n_val
    BL scanf

    // call Mult function
    LDR r0, =m_val
    LDR r0, [r0]
    LDR r1, =n_val
    LDR r1, [r1]
    BL Mult

    MOV r1, r0
    LDR r0, =result_out
    BL printf

    MOV r0, #0
    LDR lr, [sp]
    ADD sp, sp, #8
    MOV pc, lr