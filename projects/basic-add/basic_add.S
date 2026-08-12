.section .text
.org 0

.global reset

reset:
	ldi r16, 7
	ldi r17, 3
	add r16, r17

done:
	rjmp done
