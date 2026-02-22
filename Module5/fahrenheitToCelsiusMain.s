// fahrenheitToCelsiusMain.s
// Tahalil I Morsilin
// 02/16/2026

.text
.global main
main:
    // save address
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // prompt
    LDR r0, =prompt
    BL printf

    // read input
    LDR r0, =inputFormat
    LDR r1, =userInput
    BL scanf

    // load value
    LDR r0, =userInput
    LDR r0, [r0]

    // subtract 32
    SUB r0, r0, #32

    // multiply by 5
    MOV r1, #5
    MUL r0, r0, r1

    // divide by 9
    MOV r1, #9
    SDIV r0, r0, r1

    // print and return
    MOV r1, r0
    LDR r0, =outputMessage
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "Enter temperature in Fahrenheit: "
    inputFormat: .asciz "%d"
    outputMessage: .asciz "Temperature in Celsius: %d\n"
    userInput: .word 0
