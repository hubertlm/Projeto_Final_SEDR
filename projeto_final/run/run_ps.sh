#!/bin/bash

# Descoberta Dinâmica do Netlist mais recente
LATEST_OUT_DIR=$(ls -td ../genus/outputs_* 2>/dev/null | head -n 1)


NETLIST="${LATEST_OUT_DIR}/spi_top_netlist.v"
TB="../tb/spi_tb.sv"
LIB="../library/gscl45nm.v"


xrun -sv -access +r \
     -timescale 1ns/1ps \
     $LIB \
     $NETLIST \
     $TB

echo "-> Simulação concluída."
