ENTRY(_start)

SECTIONS {
	. = 0x0;
	.text : { _start = .; *(.text .text.*) }
	.data : { *(.data .rdata .data.* .rdata.*) }
	. = ALIGN(4);
	_bss_start =  .;
	.bss : { *(.bss .bss.*) }
	. = ALIGN(4);
	_bss_end = .;
	. = _start + 16384;
	_stack_top = .;
}
