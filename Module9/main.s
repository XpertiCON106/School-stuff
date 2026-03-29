// Tahalil Morsilin
// EN605 Module 9 Assignment
// 03/29/2026

.global main
.extern printf
.extern scanf

.data
// input Prompts
prmpt_char:    .asciz "\nEnter a character: "
prmpt_int:     .asciz "\nEnter an integer: "
prmpt_name:    .asciz "\nEnter student name: "
prmpt_score:   .asciz "\nEnter student score: "

// output Formats
fmt_char_in:   .asciz " %c"
fmt_int_in:    .asciz "%d"
fmt_str_in:    .asciz "%s"

fmt_out_log:   .asciz "ChkAlphaLOG: %c\n"
fmt_out_nolog: .asciz "ChkAlphaNOLOG: %c\n"
fmt_out_max:   .asciz "Maximum value is: %d\n"
fmt_out_grade: .asciz "Student Name: %s\nGrade: %c\n"
fmt_out_err:   .asciz "Error: Invalid Score entered.\n"

// Variables to store user input temporarily
in_char:       .word 0
in_val1:       .word 0
in_val2:       .word 0
in_val3:       .word 0
in_score:      .word 0
in_name:       .space 64          // this is for the allocation

.text
main:
    SUB sp, sp, #4
    STR lr, [sp]

    // testing ChkAlphaLOG
    LDR r0, =prmpt_char
    BL printf

    LDR r0, =fmt_char_in
    LDR r1, =in_char
    BL scanf

    LDR r0, =in_char
    LDR r0, [r0]
    BL ChkAlphaLOG

    CMP r0, #1
    MOVEQ r1, #'Y'
    MOVNE r1, #'N'

    LDR r0, =fmt_out_log
    BL printf

    // testing ChkAlphaNOLOG
    LDR r0, =prmpt_char
    BL printf

    LDR r0, =fmt_char_in
    LDR r1, =in_char
    BL scanf

    LDR r0, =in_char
    LDR r0, [r0]
    BL ChkAlphaNOLOG

    CMP r0, #1
    MOVEQ r1, #'Y'
    MOVNE r1, #'N'

    LDR r0, =fmt_out_nolog
    BL printf

    // testing findMAXOf3
    // reading Int 1
    LDR r0, =prmpt_int
    BL printf
    LDR r0, =fmt_int_in
    LDR r1, =in_val1
    BL scanf

    // reading Int 2
    LDR r0, =prmpt_int
    BL printf
    LDR r0, =fmt_int_in
    LDR r1, =in_val2
    BL scanf

    // reading Int 3
    LDR r0, =prmpt_int
    BL printf
    LDR r0, =fmt_int_in
    LDR r1, =in_val3
    BL scanf

    // loading into r0, r1, r2
    LDR r0, =in_val1
    LDR r0, [r0]
    LDR r1, =in_val2
    LDR r1, [r1]
    LDR r2, =in_val3
    LDR r2, [r2]

    BL findMAXOf3

    MOV r1, r0
    LDR r0, =fmt_out_max
    BL printf

    // testing grade
    // reading Name
    LDR r0, =prmpt_name
    BL printf
    LDR r0, =fmt_str_in
    LDR r1, =in_name
    BL scanf

    // reading Score
    LDR r0, =prmpt_score
    BL printf
    LDR r0, =fmt_int_in
    LDR r1, =in_score
    BL scanf

    // calling grade check
    LDR r0, =in_score
    LDR r0, [r0]
    BL Grade

    CMP r0, #'E' // we check if returned error or 'E'
    BEQ print_err

    // printing the name and grade
    MOV r2, r0
    LDR r1, =in_name
    LDR r0, =fmt_out_grade
    BL printf
    B end_main

print_err:
    LDR r0, =fmt_out_err
    BL printf

end_main:
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
