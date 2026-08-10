#include <avr/io.h>

.global main

main:
	sbi _SFR_IO_ADDR(DDRB), DDB5

blink:
	sbi _SFR_IO_ADDR(PORTB), PORTB5
	rcall delay

	cbi _SFR_IO_ADDR(PORTB), PORTB5
	rcall delay

	rjmp blink

delay:
	ldi r18, 41
outer:
	ldi r19, 255
middle:
	ldi r20, 255
inner:
	dec r20
	brne inner
	dec r19
	brne middle
	dec r18
	brne outer
	ret
