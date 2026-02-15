# Tahalil Morsilin
# Date: 02/13/2026

.text
.global main

main:
    # Save return address to stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Load and print message
    LDR r0, =tabMessage
    MOV r1, #5
    BL printf

    # Restore return address
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    tabMessage: .asciz "Number:\t%d\tEnd\n"
