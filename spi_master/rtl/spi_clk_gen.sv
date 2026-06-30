`timescale 1ns / 1ps
module spi_clk_gen (
    input  logic        clk,
    input  logic        rst,
    input  logic        en,          // Habilitado pela FSM
    input  logic [15:0] clk_div,     // Vindo do spi_regs
    input  logic [1:0]  spi_mode,    // {CPOL, CPHA}
    output logic        spi_sclk,    // Pino físico
    output logic        sample_edge, // Pulso de amostragem (MISO)
    output logic        shift_edge   // Pulso de deslocamento (MOSI)
);

    logic [15:0] counter;
    logic        sclk_int;

    // A lógica de borda depende do CPHA 
    logic cpol, cpha;
    assign cpol = spi_mode[1];
    assign cpha = spi_mode[0];

    always_ff @(posedge clk) begin
        if (!rst) begin
            counter  <= 16'd0;
            sclk_int <= 1'b0;
            sample_edge <= 1'b0;
            shift_edge  <= 1'b0;
        end else if (en) begin
            sample_edge <= 1'b0; // Garante pulso de 1 ciclo
            shift_edge  <= 1'b0;

            if (counter == clk_div - 1) begin
                counter  <= 16'd0;
                sclk_int <= ~sclk_int; 

                // Lógica de geração de Ticks baseada no CPHA
                if (cpha == 1'b0) begin
                    if (sclk_int == 1'b0) sample_edge <= 1'b1;
                    else                  shift_edge  <= 1'b1;
                end else begin
                    if (sclk_int == 1'b0) sample_edge <= 1'b1;
                    else                  shift_edge  <= 1'b1;
                end
            end else begin
                counter <= counter + 1'b1;
            end
        end else begin
            // Quando desabilitado, zera contadores e mantem estado inativo
            counter  <= 16'd0;
            sclk_int <= 1'b0;
            sample_edge <= 1'b0;
            shift_edge  <= 1'b0;
        end
    end

    // O pino físico acompanha o clock interno xor CPOL
    assign spi_sclk = (en) ? (sclk_int ^ cpol) : cpol;

endmodule