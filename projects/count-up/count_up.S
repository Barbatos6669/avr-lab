.section .text
.org 0

.global reset

reset:
	ldi r16, 0

count_up_loop:
	inc r16
	cpi r16, 10
	brne count_up_loop

done:
	rjmp done
