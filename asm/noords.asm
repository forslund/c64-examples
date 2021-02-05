.const screen = $0400
.const line1 = screen + 40*5 + 15
.const line2 = line1 + 40
.const line3 = line2 + 40

BasicUpstart2(start)

*= $8100 // Set memory origin for the program

start:


    ldx #0
text_loop:
    lda noords1,x
    beq text2
    sta line1,x
    inx
    jmp text_loop

text2:
    ldx #0
text_loop2:
    lda noords2,x
    beq text3
    sta line2,x
    inx
    jmp text_loop2

text3:
    ldx #0
text_loop3:
    lda noords3,x
    beq exit
    sta line3,x
    inx
    jmp text_loop3

exit:
rts


txt:
    .text "hello world"
    .byte 0

noords1:
// N
    .byte $F0 // hard upper left
    .byte $C9 // Soft upper right
    .byte $DD // |
// O
    .byte $D5 // Soft upper left
    .byte $C9
// O
    .byte $D5
    .byte $C9
// R
    .byte $F0
    .byte $C9
// D
    .byte $F0
    .byte $C9
// S
    .byte $D5
    .byte $C0 // -
// Null termination
    .byte 0

noords2:
// N
    .byte $DD
    .byte $DD
    .byte $DD
// O
    .byte $DD
    .byte $DD
// O
    .byte $DD
    .byte $DD
// R
    .byte $EB
    .byte $F3
// D
    .byte $DD
    .byte $DD
// S
    .byte $CA
    .byte $C9
// null termination
    .byte 0

noords3:
// N
    .byte $DD
    .byte $CA
    .byte $FD
// O
    .byte $CA
    .byte $CB
// O
    .byte $CA
    .byte $CB
// R
    .byte $DD
    .byte $DD
// D
    .byte $ED
    .byte $CB
// S
    .byte $C3
    .byte $CB
// Null termination
    .byte 0
