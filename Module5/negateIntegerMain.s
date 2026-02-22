// negateIntegerMain.s
// Tahalil I Morsilin
// 02/22/2026

.text
.global main
main:
    // save address
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // prompt user
    LDR r0, =prompt
    BL printf

    // read input
    LDR r0, =inputFormat
    LDR r1, =userInput
    BL scanf

    // load input
    LDR r0, =userInput
    LDR r0, [r0]

    // 1 complement
    MVN r1, r0

    // adding 1
    ADD r1, r1, #1

    // printing and returning
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