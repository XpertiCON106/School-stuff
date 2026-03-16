# Tahalil Morsilin
# Assignment8
# 03/15/2026
.text
.global main

main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Test miles2kilometer
    LDR r0, =prompt_miles
    BL printf

    LDR r0, =input_fmt
    LDR r1, =num_miles
    BL scanf

    LDR r0, =num_miles
    LDR r0, [r0]
    BL miles2kilometer

    MOV r1, r0
    LDR r0, =fmt_km
    BL printf

    # Test kph
    LDR r0, =prompt_hours
    BL printf

    LDR r0, =input_fmt
    LDR r1, =num_hours
    BL scanf

    LDR r0, =prompt_miles
    BL printf

    LDR r0, =input_fmt
    LDR r1, =num_miles
    BL scanf

    LDR r0, =num_hours
    LDR r0, [r0]
    LDR r1, =num_miles
    LDR r1, [r1]
    BL kph

    MOV r1, r0
    LDR r0, =fmt_kph
    BL printf

    # Test CToF
    LDR r0, =prompt_celsius
    BL printf

    LDR r0, =input_fmt
    LDR r1, =num_celsius
    BL scanf

    LDR r0, =num_celsius
    LDR r0, [r0]
    BL CToF

    MOV r1, r0
    LDR r0, =fmt_fahrenheit
    BL printf

    # Test InchesToFt
    LDR r0, =prompt_inches
    BL printf

    LDR r0, =input_fmt
    LDR r1, =num_inches
    BL scanf

    LDR r0, =num_inches
    LDR r0, [r0]
    BL InchesToFt

    MOV r1, r0
    LDR r0, =fmt_feet
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompts
    prompt_miles:   .asciz "Enter miles: "
    prompt_hours:   .asciz "Enter hours: "
    prompt_celsius: .asciz "Enter degrees Celsius: "
    prompt_inches:  .asciz "Enter inches: "

    input_fmt:      .asciz "%d"

    fmt_km:         .asciz "Kilometers: %d\n\n"
    fmt_kph:        .asciz "Kilometers per hour (KPH): %d\n\n"
    fmt_fahrenheit: .asciz "Fahrenheit: %d\n\n"
    fmt_feet:       .asciz "Feet: %d\n\n"

    num_miles:      .word 0
    num_hours:      .word 0
    num_celsius:    .word 0
    num_inches:     .word 0
