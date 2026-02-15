# Author: Tahalil Morsilin
# Date: 02/13/2026

.text
.global main

main:
    # Save return address to stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Load and print message
    LDR r0, =quoteMessage
    BL printf

    # Restore return address
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
# END OF main

.data
    # String with escaped quotes
    quoteMessage: .asciz "This is my output \"Hello world\"\n"
