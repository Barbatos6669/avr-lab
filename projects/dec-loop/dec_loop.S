.section .text
.org 0

.global reset

reset:
	ldi r16, 10

dec_loop:
	dec r16
	brne dec_loop

done:
	rjmp done
