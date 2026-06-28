
//input ports
add mapped point clk clk -type PI PI
add mapped point rst rst -type PI PI
add mapped point write_en write_en -type PI PI
add mapped point read_en read_en -type PI PI
add mapped point addr[2] addr[2] -type PI PI
add mapped point addr[1] addr[1] -type PI PI
add mapped point addr[0] addr[0] -type PI PI
add mapped point write_data[7] write_data[7] -type PI PI
add mapped point write_data[6] write_data[6] -type PI PI
add mapped point write_data[5] write_data[5] -type PI PI
add mapped point write_data[4] write_data[4] -type PI PI
add mapped point write_data[3] write_data[3] -type PI PI
add mapped point write_data[2] write_data[2] -type PI PI
add mapped point write_data[1] write_data[1] -type PI PI
add mapped point write_data[0] write_data[0] -type PI PI
add mapped point spi_miso spi_miso -type PI PI

//output ports
add mapped point read_data[7] read_data[7] -type PO PO
add mapped point read_data[6] read_data[6] -type PO PO
add mapped point read_data[5] read_data[5] -type PO PO
add mapped point read_data[4] read_data[4] -type PO PO
add mapped point read_data[3] read_data[3] -type PO PO
add mapped point read_data[2] read_data[2] -type PO PO
add mapped point read_data[1] read_data[1] -type PO PO
add mapped point read_data[0] read_data[0] -type PO PO
add mapped point spi_sclk spi_sclk -type PO PO
add mapped point spi_mosi spi_mosi -type PO PO
add mapped point spi_cs_n spi_cs_n -type PO PO

//inout ports




//Sequential Pins
add mapped point u_clk_gen/sample_edge/q u_clk_gen_sample_edge_reg/Q  -type DFF DFF
add mapped point u_clk_gen/shift_edge/q u_clk_gen_shift_edge_reg/Q  -type DFF DFF
add mapped point u_regs/start/q u_regs_start_reg/Q  -type DFF DFF
add mapped point u_clk_gen/counter[0]/q u_clk_gen_counter_reg[0]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[1]/q u_clk_gen_counter_reg[1]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[2]/q u_clk_gen_counter_reg[2]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[3]/q u_clk_gen_counter_reg[3]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[4]/q u_clk_gen_counter_reg[4]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[5]/q u_clk_gen_counter_reg[5]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[6]/q u_clk_gen_counter_reg[6]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[7]/q u_clk_gen_counter_reg[7]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[8]/q u_clk_gen_counter_reg[8]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[9]/q u_clk_gen_counter_reg[9]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[10]/q u_clk_gen_counter_reg[10]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[11]/q u_clk_gen_counter_reg[11]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[12]/q u_clk_gen_counter_reg[12]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[13]/q u_clk_gen_counter_reg[13]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[14]/q u_clk_gen_counter_reg[14]/Q  -type DFF DFF
add mapped point u_clk_gen/counter[15]/q u_clk_gen_counter_reg[15]/Q  -type DFF DFF
add mapped point u_clk_gen/sclk_int/q u_clk_gen_sclk_int_reg/Q  -type DFF DFF
add mapped point u_fsm/state[0]/q u_fsm_state_reg[0]/Q  -type DFF DFF
add mapped point u_fsm/state[1]/q u_fsm_state_reg[1]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_hi[0]/q u_regs_reg_clk_hi_reg[0]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_hi[1]/q u_regs_reg_clk_hi_reg[1]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_hi[2]/q u_regs_reg_clk_hi_reg[2]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_hi[3]/q u_regs_reg_clk_hi_reg[3]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_hi[4]/q u_regs_reg_clk_hi_reg[4]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_hi[5]/q u_regs_reg_clk_hi_reg[5]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_hi[6]/q u_regs_reg_clk_hi_reg[6]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_hi[7]/q u_regs_reg_clk_hi_reg[7]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_lo[0]/q u_regs_reg_clk_lo_reg[0]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_lo[1]/q u_regs_reg_clk_lo_reg[1]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_lo[2]/q u_regs_reg_clk_lo_reg[2]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_lo[3]/q u_regs_reg_clk_lo_reg[3]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_lo[4]/q u_regs_reg_clk_lo_reg[4]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_lo[5]/q u_regs_reg_clk_lo_reg[5]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_lo[6]/q u_regs_reg_clk_lo_reg[6]/Q  -type DFF DFF
add mapped point u_regs/reg_clk_lo[7]/q u_regs_reg_clk_lo_reg[7]/Q  -type DFF DFF
add mapped point u_regs/reg_ctrl[0]/q u_regs_reg_ctrl_reg[0]/Q  -type DFF DFF
add mapped point u_regs/reg_ctrl[1]/q u_regs_reg_ctrl_reg[1]/Q  -type DFF DFF
add mapped point u_regs/reg_ctrl[2]/q u_regs_reg_ctrl_reg[2]/Q  -type DFF DFF
add mapped point u_regs/reg_done_latch/q u_regs_reg_done_latch_reg/Q  -type DFF DFF
add mapped point u_regs/reg_rx_data[0]/q u_regs_reg_rx_data_reg[0]/Q  -type DFF DFF
add mapped point u_regs/reg_rx_data[1]/q u_regs_reg_rx_data_reg[1]/Q  -type DFF DFF
add mapped point u_regs/reg_rx_data[2]/q u_regs_reg_rx_data_reg[2]/Q  -type DFF DFF
add mapped point u_regs/reg_rx_data[3]/q u_regs_reg_rx_data_reg[3]/Q  -type DFF DFF
add mapped point u_regs/reg_rx_data[4]/q u_regs_reg_rx_data_reg[4]/Q  -type DFF DFF
add mapped point u_regs/reg_rx_data[5]/q u_regs_reg_rx_data_reg[5]/Q  -type DFF DFF
add mapped point u_regs/reg_rx_data[6]/q u_regs_reg_rx_data_reg[6]/Q  -type DFF DFF
add mapped point u_regs/reg_rx_data[7]/q u_regs_reg_rx_data_reg[7]/Q  -type DFF DFF
add mapped point u_regs/reg_tx_data[0]/q u_regs_reg_tx_data_reg[0]/Q  -type DFF DFF
add mapped point u_regs/reg_tx_data[1]/q u_regs_reg_tx_data_reg[1]/Q  -type DFF DFF
add mapped point u_regs/reg_tx_data[2]/q u_regs_reg_tx_data_reg[2]/Q  -type DFF DFF
add mapped point u_regs/reg_tx_data[3]/q u_regs_reg_tx_data_reg[3]/Q  -type DFF DFF
add mapped point u_regs/reg_tx_data[4]/q u_regs_reg_tx_data_reg[4]/Q  -type DFF DFF
add mapped point u_regs/reg_tx_data[5]/q u_regs_reg_tx_data_reg[5]/Q  -type DFF DFF
add mapped point u_regs/reg_tx_data[6]/q u_regs_reg_tx_data_reg[6]/Q  -type DFF DFF
add mapped point u_regs/reg_tx_data[7]/q u_regs_reg_tx_data_reg[7]/Q  -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
add mapped point u_datapath u_datapath -type BBOX BBOX
