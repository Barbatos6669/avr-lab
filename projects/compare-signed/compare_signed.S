.section .text
.org 0

.global reset

reset:
	ldi r16, 252
	ldi r17, 3
	cp r16, r17
	brlt lower
	ldi r18, 0
	rjmp done

lower:
	ldi r18, 1

done:
	rjmp done
