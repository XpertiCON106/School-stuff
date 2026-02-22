// multiplyByTenMain.s
// Author: Tahalil I Morsilin
// Date: 02/26/2026

.text
.global main
main:
    // save address
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // prompt
    LDR r0, =prompt
    BL printf

    // read
    LDR r0, =inputFormat
    LDR r1, =userInput
    BL scanf

    // load
    LDR r0, =userInput
    LDR r0, [r0]

    LSL r1, r0, #3
    LSL r2, r0, #1
    ADD r1, r1, r2

    // print and return 
    LDR r0, =outputMessage
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "Enter number to multiply by 10: "
    inputFormat: .asciz "%d"
    outputMessage: .asciz "Result: %d\n"
    userInput: .word 0