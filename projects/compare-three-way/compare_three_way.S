.section .text
.org 0

.global reset

reset:
    ldi r16, 3      ; Load immediate value 3 into register r16
    ldi r17, 7      ; Load immediate value 7 into register r17
    cp r16, r17     ; Subtracts r16 - r17
    breq equal      ; If equal, branch to equal
    brlo lower      ; If r16 < r17, branch to lower
    rjmp higher     ; If r16 > r17, jump to higher

lower:
    ldi r18, 0      ; Set r18 to 0 to indicate r16 is lower
    rjmp done       ; Jump to done

equal:
    ldi r18, 1      ; Set r18 to 1 to indicate r16 is equal to r17
    rjmp done       ; Jump to done

higher:
    ldi r18, 2      ; Set r18 to 2 to indicate r16 is higher than r17
    rjmp done       ; Jump to done

done:
    rjmp done       ; Infinite loop to end the program
