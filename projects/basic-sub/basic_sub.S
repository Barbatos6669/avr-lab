.section .text
.org 0

.global reset

reset:
	ldi r16, 3
	ldi r17, 7
	sub r16, r17

done:
	rjmp done
