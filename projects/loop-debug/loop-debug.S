.section .text
.org 0

.global reset

reset:
    ; Small counters make the nested loops practical to single-step.
    ldi r18, 2

outer:
    ldi r19, 2

middle:
    ldi r20, 3

inner:
    dec r20
    brne inner

    dec r19
    brne middle

    dec r18
    brne outer

done:
    ; Stop at a stable instruction after all three loops finish.
    rjmp done
