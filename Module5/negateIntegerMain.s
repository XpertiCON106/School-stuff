// negateIntegerMain.s
// Tahalil I Morsilin
// 02/22/2026

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

    MVN r1, r0

    ADD r1, r1, #1

    // print and return 
    LDR r0, =outputMessage
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "Enter an integer: "
    inputFormat: .asciz "%d"
    outputMessage: .asciz "The negative is: %d\n"
    userInput: .word 0