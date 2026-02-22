// feetInchesToInchesMain.s
// Author: Tahalil I Morsilin
// Date: 02/22/2026

.text
.global main
main:
    // save address
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // prompt feet
    LDR r0, =promptFeet
    BL printf

    LDR r0, =inputFormat
    LDR r1, =feetInput
    BL scanf

    // prompt inches
    LDR r0, =promptInches
    BL printf

    LDR r0, =inputFormat
    LDR r1, =inchesInput
    BL scanf

    // total
    LDR r0, =feetInput
    LDR r0, [r0]
    
    MOV r1, #12
    MUL r0, r0, r1 

    LDR r1, =inchesInput
    LDR r1, [r1]
    
    ADD r1, r0, r1

    // print and return
    LDR r0, =resultMessage
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    promptFeet: .asciz "Enter feet: "
    promptInches: .asciz "Enter inches: "
    inputFormat: .asciz "%d"
    resultMessage: .asciz "Total inches: %d\n"
    feetInput: .word 0
    inchesInput: .word 0