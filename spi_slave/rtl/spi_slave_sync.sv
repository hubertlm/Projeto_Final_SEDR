module spi_slave_sync (
    input  logic clk, 
    input  logic rst,
    input  logic spi_sclk, 
    input  logic spi_mosi, 
    input  logic spi_cs_n,
    output logic sclk_sync, 
    output logic mosi_sync, 
    output logic cs_n_sync,
    output logic sclk_rise, 
    output logic sclk_fall
);
    logic [2:0] sclk_r, mosi_r, cs_n_r;

    always_ff @(posedge clk) begin
        if (rst) begin
            sclk_r <= 3'b0; mosi_r <= 3'b0; cs_n_r <= 3'b1;
        end else begin
            sclk_r <= {sclk_r[1:0], spi_sclk};
            mosi_r <= {mosi_r[1:0], spi_mosi};
            cs_n_r <= {cs_n_r[1:0], spi_cs_n};
        end
    end

    assign sclk_sync = sclk_r[2];
    assign mosi_sync = mosi_r[2];
    assign cs_n_sync = cs_n_r[2];

    assign sclk_rise = (sclk_r[2:1] == 2'b01);
    assign sclk_fall = (sclk_r[2:1] == 2'b10);
endmodule