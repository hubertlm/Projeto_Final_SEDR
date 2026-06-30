#!/bin/bash
xrun -64bit -sv \
../rtl/spi_clk_gen.sv \
../rtl/spi_controller.sv \
../rtl/spi_data.sv \
../rtl/spi_regs.sv \
../rtl/spi_top.sv \
../tb/spi_tb.sv \
-access +rwc
