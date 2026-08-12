.section .text
.org 0

.global reset

reset:
    ldi r16, 252
    ldi r17, 3

    ldi r18, 0
    ldi r19, 0

    cp r16, r17
    brlo unsigned_lower
    rjmp unsigned_done

unsigned_lower:
    ldi r18, 1

unsigned_done:
    cp r16, r17
    brlt signed_lower
    rjmp done

signed_lower:
    ldi r19, 1

done:
    rjmp done
