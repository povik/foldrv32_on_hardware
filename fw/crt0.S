.text

.extern _stack_top
.globl _start, enable_irqs

_start:
	la sp, _stack_top
	call clear_bss
	call main
end:
	wfi
	j end
