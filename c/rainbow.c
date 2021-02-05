#include <stdio.h>
#include <string.h>


#define MEM_CENTER_COLOR (char *)0xd021
#define MEM_BORDER_COLOR (char *)0xd020
void set_background(char center_color, char border_color)
{
    char *border, *center;
    border = MEM_CENTER_COLOR;
    center = MEM_BORDER_COLOR;
    *center = center_color;
    *border = border_color;
}    
char *mem_screen = (char *)0x400;
char *mem_color = (char *)0xd800;


void clear_screen()
{
    __asm__("lda #%b", 0x20); // ' ' in X
    __asm__("ldx #$0");
    __asm__("clearloop:");
    __asm__("sta %w,x", 0x400);
    __asm__("sta %w,x", 0x500);
    __asm__("sta %w,x", 0x600);
    __asm__("sta %w,x", 0x700);
    __asm__("inx");
    __asm__("cpx #%w", 0);
    __asm__("bne clearloop");
}

int printoffset = 0;

void printpos(int col, int row)
{
    printoffset = col + (row * 40);
}

static char color[] = {1, 10, 2, 4, 6, 14, 3, 5, 13, 7, 8};

void rainbowprintf(const char offset, const char *fmt, ...)
{
    va_list arg;
    char buff[200];
    unsigned char len, i;
    vsprintf(buff, fmt, arg);
    len = strlen(buff);
    for (i = 0; i < len; i++)
    {
        *(mem_color + printoffset + i) = color[(i + offset) % 9];
        *(mem_screen + printoffset + i) = buff[i];    
    }
}


void delay(int c)
{
    int i;
    for (i = 0; i < c; i++)
        __asm__("nop");
}


void fade_to_black(void)
{
    delay(1000);
    set_background(1, 1);
    delay(255);
    set_background(15, 15);
    delay(255);
    set_background(12, 12);
    delay(255);
    set_background(11, 11);
    delay(255);
    set_background(0, 0);
    delay(255);
}


int main(void)
{
    char o = 0;
    clear_screen();
    fade_to_black();
    printpos(14, 6);
    while(1)
    {
        if (o & 0x2)
        {
            rainbowprintf(o / 2, "hello rainbow!!!");
        }
        o++;
    }
    return 0;
}
