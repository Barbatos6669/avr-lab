.section .text
.org 0

.global reset

reset:
	ldi r16, 3
	ldi r17, 7
	cp r16, r17
	brlo lower
	ldi r18, 0
	rjmp done

lower:
	ldi r18, 1

done:
	rjmp done
