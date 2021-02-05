.const screen = $0400

BasicUpstart2(start)

*= $8100 // Set memory origin for the program

clear_screen:
    lda #$20
    ldx #0
clear_loop:
// characters
    .var offset
    .for(offset=0; offset<4; offset++) {
        sta screen + $100 * offset, x
    }
//  Loop and check for end condition
    inx
    cpx #0
    bne clear_loop
    rts



start:
    jsr clear_screen

    ldx #0
text_loop:
    lda txt,x
    beq exit
    sta screen,x
    inx
    jmp text_loop

exit:
rts


txt:
    .text "hello world"
    .byte 0
