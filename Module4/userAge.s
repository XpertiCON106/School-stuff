# Tahalil Morsilin
# Date: 02/13/2026

.text
.global main

main:
    # Save return address to stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt user for input
    LDR r0, =promptMessage
    BL printf

    # Read integer from user
    # r0 = format string, r1 = address of variable
    LDR r0, =inputFormat
    LDR r1, =userAge
    BL scanf

    # Print the result
    LDR r0, =outputMessage
    LDR r1, =userAge
    LDR r1, [r1]
    BL printf

    # Restore return address
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    userAge: .word 0

    promptMessage: .asciz "Enter your age: "
    inputFormat:   .asciz "%d"
    outputMessage: .asciz "Your age is: %d\n"
