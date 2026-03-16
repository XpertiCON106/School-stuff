# Tahalil Morsilin
# Assignment8
# 03/15/2026

.text
.global miles2kilometer
.global kph
.global CToF
.global InchesToFt

miles2kilometer:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Calculate: (miles * 161) / 100
    MOV r1, #161
    MUL r0, r0, r1
    MOV r1, #100
    BL __aeabi_idiv

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

kph:
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r0, [sp, #4]

    MOV r0, r1
    BL miles2kilometer

    LDR r1, [sp, #4]
    BL __aeabi_idiv

    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr

CToF:
    # Save lr to stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r1, #9
    MUL r0, r0, r1
    MOV r1, #5
    BL __aeabi_idiv
    ADD r0, r0, #32

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

InchesToFt:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r1, #12
    BL __aeabi_idiv

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
