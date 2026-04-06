// Tahalil Morsilin
// EN605
// Module 10
// 04/05/2026

.data
prompt:     .asciz "Enter n: "
format_in:  .asciz "%d"
format_out: .asciz "%d\n"
n_val:      .word 0             // allocate 4 bytes on a word boundary for user input

    .text
    .global main

main:
    SUB sp, sp, #24             // allocate space for 6 registers
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    STR r6, [sp, #12]
    STR r7, [sp, #16]
    STR r8, [sp, #20]

    // Print prompt
    LDR r0, =prompt
    BL printf

    // Read user input 'n'
    LDR r0, =format_in
    LDR r1, =n_val
    BL scanf
    LDR r1, =n_val
    LDR r5, [r1]                // load n into r5

    // Outer Loop Initialization
    MOV r4, #3                  // start testing at 3

outer_loop_start:
    CMP r4, r5                  // check end condition
    BGT outer_loop_end

    // Inner Loop Initialization
    MOV r6, #2                  // divisor starts at 2
    LSR r7, r4, #1              // calculate current_number / 2 (limit for divisor)

inner_loop_start:
    CMP r6, r7
    BGT is_prime                // If divisor > n/2 without finding a remainder, it is prime

    // Manual Remainder Logic: r8 = r4 % r6 (Repeated Subtraction)
    MOV r8, r4
rem_loop:
    CMP r8, r6
    BLT rem_done
    SUB r8, r8, r6
    B rem_loop
rem_done:
    CMP r8, #0                  // If remainder is 0, it is divisible (not prime)
    BEQ not_prime

    // Get next divisor
    ADD r6, r6, #1
    B inner_loop_start          // Branch to start label

is_prime:
    // Implement the loop block
    LDR r0, =format_out
    MOV r1, r4
    BL printf

not_prime:
    // Get next number
    ADD r4, r4, #1
    B outer_loop_start          // Branch to start label

outer_loop_end:
    // Restore registers and exit
    LDR lr, [sp, #0]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    LDR r6, [sp, #12]
    LDR r7, [sp, #16]
    LDR r8, [sp, #20]
    ADD sp, sp, #24

    MOV r0, #0
    BX lr
