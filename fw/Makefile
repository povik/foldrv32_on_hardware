ARCH = -mabi=ilp32e -march=rv32e -mstrict-align
PREFIX = riscv32-none-elf-
CC = $(PREFIX)gcc
CFLAGS = $(ARCH) -MD -Wbuiltin-declaration-mismatch -I. -DNDEBUG $(DEFS) -fdata-sections -ffunction-sections
ASFLAGS = $(ARCH)
LDSCRIPT = linker.ld
OBJS = crt0.o crt1.o main.o vsprintf.o
BINARY = image.elf
BINARY_AUX = image.tsv image.elf.dump image.elf.dump2 image.bin image.hex

WM_SIZE = 16384

default: image.elf image.tsv image.elf.dump image.elf.dump2

clean:
	rm -f $(BINARY) $(OBJS) $(BINARY_AUX) $(OBJS:.o=.d)

%.tsv: %.bin
	python3 to_tsv.py < $^ > $@

%.bin: %.elf
	$(PREFIX)objcopy --pad-to $(WM_SIZE) -O binary $^ $@

%.hex: %.elf
	$(PREFIX)objcopy --pad-to $(WM_SIZE) -O ihex $^ $@

%.elf.dump: %.elf
	$(PREFIX)objdump -d $^ > $@

%.elf.dump2: %.elf
	$(PREFIX)objdump -M no-aliases -d $^ > $@

$(BINARY): $(OBJS) $(LDSCRIPT)
	$(PREFIX)gcc -o $@ -nostdlib -T $(LDSCRIPT) $(OBJS) -lgcc

-include $(OBJS:.o=.d)
