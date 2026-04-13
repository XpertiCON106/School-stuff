// EN605
// Module 11 Assignment
// Tahalil I Morsilin
// 04/12/2026

.data
prompt_n:   .asciz "Enter an integer n: "
format_in:  .asciz "%d"
result_out: .asciz "Fibonacci(%d) = %d\n"

n_val:      .word 0

.text
.global main

// problem 2
Fib:
    SUB sp, sp, #16
    STR lr, [sp]
    STR r4, [sp, #4]
    STR r5, [sp, #8]

    MOV r4, r0

    // if (n == 0) return 0
    CMP r4, #0
    BNE Fib_Check1
    MOV r0, #0
    B Fib_Return

Fib_Check1:
    // if (n == 1) return 1
    CMP r4, #1
    BNE Fib_Else
    MOV r0, #1
    B Fib_Return

Fib_Else:
    // Fib(n-1)
    SUB r0, r4, #1
    BL Fib
    MOV r5, r0              // Save F(n-1) in r5

    // Fib(n-2)
    SUB r0, r4, #2
    BL Fib                  // Return value is in r0

    // Add F(n-1) + F(n-2)
    ADD r0, r5, r0

Fib_Return:
    LDR lr, [sp]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #16
    MOV pc, lr

main:
    SUB sp, sp, #8
    STR lr, [sp]

    // prompt for n
    LDR r0, =prompt_n
    BL printf
    LDR r0, =format_in
    LDR r1, =n_val
    BL scanf

    // call Fib(n)
    LDR r0, =n_val
    LDR r0, [r0]
    BL Fib

    MOV r2, r0
    LDR r1, =n_val
    LDR r1, [r1]
    LDR r0, =result_out
    BL printf

    MOV r0, #0
    LDR lr, [sp]
    ADD sp, sp, #8
    MOV pc, lr