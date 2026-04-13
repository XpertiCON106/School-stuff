// EN605
// Module 11 Assignment
// Tahalil I Morsilin
// 04/12/2026

.data
prompt_msg: .asciz "Enter a non-negative integer n (max 12): "
err_neg:    .asciz "Error: Input cannot be negative.\n"
err_max:    .asciz "Error: Input exceeds safe max of 12 (overflow risk).\n"
format_in:  .asciz "%d"
result_out: .asciz "Factorial(%d) = %d\n"

n_val:      .word 0

.text
.global main

// problem 3
MultHelper:
    MOV r2, r0
    MOV r0, #0
    
    CMP r1, #0              // If b == 0, return 0 immediately
    BEQ MultHelper_Return

MultHelper_Loop:
    ADD r0, r0, r2          // sum += a
    SUB r1, r1, #1          // b--
    CMP r1, #0
    BGT MultHelper_Loop     // keep looping while b > 0

MultHelper_Return:
    MOV pc, lr

// this is the recursive factorial function
Factorial:
    SUB sp, sp, #8          // Allocate stack
    STR lr, [sp]
    STR r4, [sp, #4]        // Save r4 (n)

    MOV r4, r0              // r4 = n

    // if (n <= 1) return 1
    CMP r4, #1
    BGT Fact_Else
    MOV r0, #1
    B Fact_Return

Fact_Else:
    // Compute Factorial(n-1)
    SUB r0, r4, #1
    BL Factorial            // r0 = Factorial(n-1)

    // Compute n * Factorial(n-1) using helper
    MOV r1, r0              // r1 = Factorial(n-1) (the multiplier 'b')
    MOV r0, r4              // r0 = n (the multiplicand 'a')
    BL MultHelper           // Computes r0 = n * Factorial(n-1) without MUL

Fact_Return:
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

main:
    SUB sp, sp, #8
    STR lr, [sp]

    // prompt user
    LDR r0, =prompt_msg
    BL printf

    // prompt for n
    LDR r0, =format_in
    LDR r1, =n_val
    BL scanf

    LDR r4, =n_val
    LDR r4, [r4]

    // validation: check for negative
    CMP r4, #0
    BLT Main_Err_Neg

    // validation: check safe max (12)
    CMP r4, #12
    BGT Main_Err_Max

    MOV r0, r4
    BL Factorial

    MOV r2, r0              // r2 = Result
    MOV r1, r4              // r1 = Original n
    LDR r0, =result_out
    BL printf
    B Main_Exit

Main_Err_Neg:
    LDR r0, =err_neg
    BL printf
    B Main_Exit

Main_Err_Max:
    LDR r0, =err_max
    BL printf

Main_Exit:
    MOV r0, #0
    LDR lr, [sp]
    ADD sp, sp, #8
    MOV pc, lr