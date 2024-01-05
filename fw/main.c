#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

int vsprintf(char *buf, const char *fmt, va_list args);
int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);

int gcd(int a, int b)
{
    if (a == b) return a;
    else if (a > b) return gcd(a - b, b);
    else return gcd(b - a, a);
}

int puts(const char *s)
{
    while (*s) {
        while (*((volatile int *) 0x80000004) & 1);
        *((volatile int *) 0x80000000) = *s++;
    }
}

int printf(const char *fmt, ...)
{
    va_list args;
    char buf[128];
    va_start(args, fmt);
    int ret = vsnprintf(buf, sizeof(buf), fmt, args);
    va_end(args);
    puts(buf);
    return ret;
}

void main() {
    *((volatile int *) 0x80000008) = 0;
    int a = 98, b = 54;
    printf("gcd(%d, %d) = %d\r\n", a, b, gcd(a, b));
    while (1);
}
