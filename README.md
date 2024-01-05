# Sample Fold design

This sample combines a simple RISC-V core with a minimal UART transmitter controlled by memory-mapped registers. 

## To build

First build the firmware

	make -C fw

Then build the Fold design (for which you need to supply a path to a checkout of the [Fold compiler repository](https://github.com/povik/fold))

	FOLD_PATH=... make
