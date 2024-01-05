YOSYS := $(YOSYS_PREFIX)yosys
FOLD_LOGIC := PYTHONPATH=$(FOLD_PATH):$$PYTHONPATH python3 -m fold.logic
FOLD_MACHINECODE := PYTHONPATH=$(FOLD_PATH):$$PYTHONPATH python3 -m fold.machinecode

build/top.pre-io-amending.il: src/core.fold src/top.fold fw/image.tsv
	$(FOLD_LOGIC) -o $@ src/core.fold src/top.fold

build/top.il: build/top.pre-io-amending.il
	$(YOSYS) -p "portlist; connect -nounset -set uart_tx_pin_ivalid 1; delete -input w:*_ivalid; write_rtlil $@" $^

build/%.presynth.il: build/top.il board/%/upper_top.v
	$(YOSYS) -p "read_rtlil build/top.il; read_verilog board/$*/upper_top.v; hierarchy -top upper_top; \
				 delete t:?print t:?assert t:MUTEX_ASSERT; stat; write_rtlil $@"

exec: src/core.fold src/top_mcode.fold fw/image.tsv
	$(FOLD_MACHINECODE) -e src/core.fold src/top_mcode.fold

sim: build/top.il
	$(YOSYS) -p "read_rtlil $^; read_verilog -sv $(FOLD_PATH)/support/mutex_assert.sv; \
				 hierarchy -top top; proc; memory_nordff; sim -clock clk -reset rst -q -n 8000;"

clean:
	rm -f build/*
