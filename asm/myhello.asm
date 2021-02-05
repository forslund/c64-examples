.const screen = $0400

BasicUpstart2(start)

*= $8100 // Set memory origin for the program

start:


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
