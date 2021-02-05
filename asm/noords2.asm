.const screen = $0400
.const line1 = screen + 40 * 5 + 15
.const line2 = line1 + 40
.const line3 = line2 + 40
.const dot_pos = line1 - 40 + 3

.const border_color = $d020
.const bg_color = $d021
.const color_map = $d800

.const dot_color_pos = color_map + 40 * 4 + 18 

.const orange = 8
.const black = 0
.const white = 1
BasicUpstart2(start)

*= $8100 // Set memory origin for the program

clear_screen:
//    lda #$E0
    lda #$20
    ldx #0
clear_loop:
// characters
    sta $400,x
    sta $500,x
    sta $600,x
    sta $700,x
// colors
    sta color_map,x
    sta color_map+$100,x
    sta color_map+$200,x
    sta color_map+$300,x
//
    inx
    cpx #0
    bne clear_loop
    rts

print_routine:
    ldx #0
text_loop:
    lda noords1,x
    beq print_exit
print_pos:
    sta line1,x
    inx
    jmp text_loop
print_exit:
    ldx #0
    rts


print_dots:
    // Update position to dots
    lda #<dot_pos
    sta print_pos+1
    lda #>dot_pos
    sta print_pos+2

    // Use the dots
    lda #<dot_text
    sta text_loop+1
    lda #>dot_text
    sta text_loop+2

    jsr print_routine
    rts



start:

jsr clear_screen

// Set Colors
lda #black
sta border_color
lda #orange
sta bg_color
lda #21
sta 53272

// Use the noords1 string
lda #<noords1
sta text_loop+1
lda #>noords1
sta text_loop+2

jsr print_routine

// Update position to next line
lda #<line2
sta print_pos+1
lda #>line2
sta print_pos+2

// Use the noords2 string
lda #<noords2
sta text_loop+1
lda #>noords2
sta text_loop+2

jsr print_routine

// Update position to next line
lda #<line3
sta print_pos+1
lda #>line3
sta print_pos+2

// Use the noordsr3 string
lda #<noords3
sta text_loop+1
lda #>noords3
sta text_loop+2

jsr print_routine

// Update position to next line
lda #<line3+50
sta print_pos+1
lda #>line3+50
sta print_pos+2

// Use the Scania string
lda #<scania
sta text_loop+1
lda #>scania
sta text_loop+2

// Print the dots
sta dot_color_pos
sta dot_color_pos + 1
sta dot_color_pos + 2
sta dot_color_pos + 3
jsr print_dots
exit:
rts


dot_text:
    .byte $D3
    .byte $D3
    .byte $D3
    .byte $D3
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
    .byte $AB
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
scania:
    .text "of scania"
    .byte 0
