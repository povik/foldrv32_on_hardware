#include <stdint.h>

extern uint32_t _bss_start;
extern uint32_t _bss_end;

void clear_bss()
{
	for (uint32_t *p = &_bss_start; p != &_bss_end; p++)
		*p = 0;
}
