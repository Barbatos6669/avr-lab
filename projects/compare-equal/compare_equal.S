.section .text
.org 0

.global reset

reset:
	ldi r16, 7	; load register 16 with 7
	ldi r17, 7	; load register 17 with 7
	cp r16, r17	; Compare by calculating r16 - r17
	breq if_equal	; Branch when z = 1
	ldi r18, 0	; load register r18 with 0
	rjmp done	; skip the equal path

if_equal:
	ldi r18, 1	; if z = 1 load register r18 with 1

done:
	rjmp done	; Loop forever
