.section .text
.org 0

    rjmp reset

reset:
    ; PB5 = Uno built-in LED pin
    sbi 0x04, 5        ; DDRB: make PB5 an output

main:
    sbi 0x05, 5        ; PORTB: LED on
    rcall delay

    cbi 0x05, 5        ; PORTB: LED off
    rcall delay

    rjmp main

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
