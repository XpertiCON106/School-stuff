// Tahalil Morsilin
// EN605 Module 9 Assignment
// 03/29/2026

.global ChkAlphaLOG
.global ChkAlphaNOLOG
.global findMAXOf3
.global Grade

.text

// ChkAlphaLOG
// by using logical operations, we wil check if an input is alphabetic
// returns 1 which is true or 0 for false  in r0.
ChkAlphaLOG:
    SUB sp, sp, #4          // allocate the space on the stack
    STR lr, [sp]            // store link register

    // check uppercase 'A' = 0x41 and 'Z' = 0x5A
    MOV r2, #0
    CMP r0, #0x41           // comparing with 'A'
    ADDGE r2, #1            // if >= 'A', set bit 0 to 1

    MOV r3, #0
    CMP r0, #0x5A           // comparing with 'Z'
    ADDLE r3, #1            // if <= 'Z', set bit 0 to 1

    AND r2, r2, r3          // if uppercase, r2 = 1 else r2 = 0

    // check lowercase 'a' = 0x61 and'z' = 0x7A
    MOV r1, #0
    CMP r0, #0x61           // comparing with 'a'
    ADDGE r1, #1            // if >= 'a', set bit 0 to 1

    MOV r3, #0
    CMP r0, #0x7A           // comparing with 'z'
    ADDLE r3, #1            // if <= 'z', set bit 0 to 1

    AND r3, r3, r1          // if lowercase,r3 = 1 else r3 = 0

    // now we check for both uppercase and lowercase
    OR r0, r2, r3           // if uppercase or lowercase then r0 = 1 or set to true

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

// ChkAlphaNOLOG(char inchar)
// checks if input is alphabetic using branches
// returns 1 (true) or 0 (false) in r0
ChkAlphaNOLOG:
    SUB sp, sp, #4
    STR lr, [sp]

    CMP r0, #0x41           // check if < 'A'
    BLT not_alpha
    CMP r0, #0x5A           // check if <= 'Z'
    BLE is_alpha
    CMP r0, #0x61           // check if < 'a'
    BLT not_alpha
    CMP r0, #0x7A           // check if <= 'z'
    BLE is_alpha
    B not_alpha             // cefault to not alpha

is_alpha:
    MOV r0, #1
    B end_nolog
not_alpha:
    MOV r0, #0
end_nolog:
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

// findMAXOf3(val1, val2, val3) all values are int type
// returns maximum value of 3 which will be stored in the r0
findMAXOf3:
    SUB sp, sp, #4
    STR lr, [sp]

    // we will assume that val1 which is r0 is at value at the start
    CMP r1, r0              // compare val2 with current max
    BLE check_val3
    MOV r0, r1              // if val2 > max, we will update max

check_val3:
    CMP r2, r0              // now compare val3 with current max
    BLE end_max
    MOV r0, r2              // if val3 > max, we wil update max

end_max:
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

// Grade(score), score is of type int
Grade:
    SUB sp, sp, #4
    STR lr, [sp]

    CMP r0, #0              // check if score < 0
    BLT error_grade
    CMP r0, #100            // check if score > 100
    BGT error_grade

    CMP r0, #90             // if score >= 90
    BGE grade_A
    CMP r0, #80             // elsif score >= 80
    BGE grade_B
    CMP r0, #70             // elsif score >= 70
    BGE grade_C
    B grade_F               // else [cite: 197]

grade_A:
    MOV r0, #'A'
    B end_grade
grade_B:
    MOV r0, #'B'
    B end_grade
grade_C:
    MOV r0, #'C'
    B end_grade
grade_F:
    MOV r0, #'F'
    B end_grade

error_grade:
    MOV r0, #'E' // this is for error 'E'

end_grade:
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
