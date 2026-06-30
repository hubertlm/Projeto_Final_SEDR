module spi_slave_datapath (
    input  logic clk, 
    input  logic rst,
    input  logic sclk_fall, 
    input  logic cs_n_sync, 
    input  logic shift_en,
    input  logic mosi_sync,
    input  logic [7:0] tx_data,
    output logic [7:0] rx_data,
    output logic spi_miso
);
    logic [7:0] rx_reg, tx_reg;

    always_ff @(posedge clk) begin
        if (rst) rx_reg <= 8'h00;
        else if (shift_en) rx_reg <= {rx_reg[6:0], mosi_sync};
    end

    always_ff @(posedge clk) begin
        if (cs_n_sync) tx_reg <= tx_data;
        else if (sclk_fall) tx_reg <= {tx_reg[6:0], 1'b0};
    end

    assign rx_data = rx_reg;
    assign spi_miso = (!cs_n_sync) ? tx_reg[7] : 1'bz;
endmodule