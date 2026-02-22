// inchesToFeetInchesMain.s
// Author: Tahalil I Morsilin
// Date: 02/22/2026

.text
.global main
main:
    // save address
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // prompt
    LDR r0, =prompt
    BL printf

    LDR r0, =inputFormat
    LDR r1, =totalInches
    BL scanf

    // loading inches
    LDR r0, =totalInches
    LDR r0, [r0]

    // calculations
    MOV r1, #12
    SDIV r2, r0, r1
    MUL r3, r2, r1
    SUB r3, r0, r3

    // printing and return 
    MOV r1, r2
    MOV r2, r3
    LDR r0, =outputMessage
    BL printf
    
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "Enter total inches: "
    inputFormat: .asciz "%d"
    outputMessage: .asciz "%d feet and %d inches\n"
    totalInches: .word 0