module spi_slave_top (
    input  logic clk, 
    input  logic rst,
    // Barramento CPU 
    input  logic write_en,
    input  logic read_en,
    input  logic [2:0] addr,
    input  logic [7:0] write_data, 
    output logic [7:0] read_data,
    // Interface SPI
    input  logic spi_sclk, 
    input  logic spi_mosi, 
    input  logic spi_cs_n,
    output logic spi_miso
);
    logic sclk_sync; 
    logic mosi_sync; 
    logic cs_n_sync; 
    logic sclk_rise; 
    logic sclk_fall; 
    logic shift_en;
    logic done;
    logic [7:0] tx_data; 
    logic [7:0] rx_data;

    spi_slave_sync u_sync (.*);
    spi_slave_controller u_fsm (.*);
    spi_slave_datapath u_dp (.*);
    
    spi_regs u_regs (
        .clk(clk), 
        .rst_n(!rst),
        .write_en, 
        .read_en, 
        .addr, 
        .write_data, 
        .read_data,
        .tx_data(tx_data), 
        .hw_rx_data(rx_data), 
        .hw_done(done),
        .hw_busy(cs_n_sync)
    );
endmodule