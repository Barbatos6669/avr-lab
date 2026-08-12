.section .text
.org 0

.global reset

reset:
    ldi  r16, 7      ; Load r16 with 7
    ldi  r17, 7      ; Load r17 with 7
    cp   r16, r17    ; Compare r16 - r17
    breq if_equal    ; Branch when Z = 1
    ldi  r18, 0      ; Record not equal
    rjmp done        ; Skip the equal path

if_equal:
    ldi  r18, 1      ; Record equal

done:
    rjmp done        ; Loop forever
