// celsiusToFahrenheitMain.s
// Author: Tahalil I Morsilin
// Date: 02/20/2026

.text
.global main
main:
    // save return address
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // prompt for input
    LDR r0, =prompt
    BL printf

    // read input
    LDR r0, =inputFormat
    LDR r1, =userInput
    BL scanf

    // load into r0
    LDR r0, =userInput
    LDR r0, [r0]

    // Calculate F = (C * 9) / 5 + 32
    // multiply by 9
    MOV r1, #9
    MUL r0, r0, r1

    // divide by 5
    MOV r1, #5
    SDIV r0, r0, r1

    // add 32
    ADD r0, r0, #32

    // print and return 
    MOV r1, r0
    LDR r0, =outputMessage
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "Enter temperature in Celsius: "
    inputFormat: .asciz "%d"
    outputMessage: .asciz "Temperature in Fahrenheit: %d\n"
    userInput: .word 0