// Tahalil Morsilin
// EN605
// 04/05/2026

.data
prompt:         .asciz "\nEnter a number (-1 to exit): "
format_in:      .asciz "%d"
msg_prime:      .asciz "Number %d is prime\n"
msg_not_prime:  .asciz "Number %d is not prime\n"
msg_error:      .asciz "Error: Input must be greater than 2.\n"
num_val:        .word 0         // Allocate 4 bytes on a word boundary

    .text
    .global main

main:
    // Save registers to the stack manually
    SUB sp, sp, #24
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    STR r6, [sp, #12]
    STR r7, [sp, #16]
    STR r8, [sp, #20]

input_loop:
    // Print prompt
    LDR r0, =prompt
    BL printf

    // Read user input
    LDR r0, =format_in
    LDR r1, =num_val
    BL scanf
    LDR r1, =num_val
    LDR r4, [r1]

    // Check for exit condition (-1)
    CMP r4, #-1
    BEQ end_program

    // Error check (0, 1, 2 or negative inputs)
    CMP r4, #2
    BLE print_error

    // Initialize Prime Check Loop
    MOV r5, #2                  // Divisor starts at 2
    LSR r6, r4, #1              // Loop limit = input_number / 2
    MOV r7, #1                  // Assume prime (is_prime = 1)

check_loop:
    CMP r5, r6                  // Check end condition
    BGT check_done

    // Implement the loop block (Manual remainder logic via repeated subtraction)
    MOV r8, r4
rem_loop_2:
    CMP r8, r5
    BLT rem_done_2
    SUB r8, r8, r5
    B rem_loop_2
rem_done_2:
    CMP r8, #0
    BNE continue_check

    // Divisor found, not prime
    MOV r7, #0                  // is_prime = 0
    B check_done                // Break inner loop

continue_check:
    // Get next divisor
    ADD r5, r5, #1
    B check_loop                // Branch to start label

check_done:
    // Determine output based on is_prime flag
    CMP r7, #1
    BEQ print_is_prime

    // Print not prime
    LDR r0, =msg_not_prime
    MOV r1, r4
    BL printf
    B input_loop                // Return to prompt

print_is_prime:
    LDR r0, =msg_prime
    MOV r1, r4
    BL printf
    B input_loop                // Return to prompt

print_error:
    // Print error message
    LDR r0, =msg_error
    BL printf
    B input_loop                // Return to prompt

end_program:
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
