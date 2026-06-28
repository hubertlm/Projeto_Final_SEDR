`timescale 1ns / 1ps
module spi_data (
    input  logic       clk,
    input  logic       rst,

    // Interface de Dados com spi_regs
    input  logic [7:0] tx_data,
    output logic [7:0] rx_data,

    // Interface de Controle com a FSM (spi_controller)
    input  logic       load_en,
    input  logic       shift_en,
    output logic       bit_cnt_max,

    // Interface de Sincronização com spi_clk_gen
    input  logic       sample_edge,
    input  logic       shift_edge,

    // Interface Física (Pinos)
    output logic       spi_mosi,
    input  logic       spi_miso
);

    logic [7:0] rx_shift_reg;
    logic [6:0] tx_shift_reg; 
    logic [2:0] bit_counter;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            tx_shift_reg <= 7'b0;
            rx_shift_reg <= 8'h00;
            bit_counter  <= 3'd0;
            bit_cnt_max  <= 1'b0;
            spi_mosi     <= 1'b0;
        end else begin
            if (load_en) begin
                // O MSB (Bit 7) vai direto para o pino de saída.
                spi_mosi     <= tx_data[7];
                
                // Os 7 bits restantes ficam no registrador aguardando o deslocamento
                tx_shift_reg <= tx_data[6:0];
                
                bit_counter  <= 3'd0;
                bit_cnt_max  <= 1'b0;
                
            end else if (shift_en) begin
                // Atualiza o pino MOSI com o próximo bit
                if (shift_edge) begin
                    spi_mosi     <= tx_shift_reg[6];           // Extrai o novo MSB
                    tx_shift_reg <= {tx_shift_reg[5:0], 1'b0}; // Desloca para a esquerda
                end

                // Captura o pino MISO
                if (sample_edge) begin
                    rx_shift_reg <= {rx_shift_reg[6:0], spi_miso}; // Insere no LSB
                    
                    // Incrementa o contador e verifica se a transferência do byte acabou
                    if (bit_counter == 3'd7) begin
                        bit_cnt_max <= 1'b1; // Dispara a flag avisando a FSM
                    end else begin
                        bit_counter <= bit_counter + 3'd1;
                    end
                end
            end else begin
                // Garante que a flag seja limpa no ciclo seguinte ao fim do shift_en
                bit_cnt_max <= 1'b0;
            end
        end
    end

    // Mapeia o registrador de recepção diretamente para a porta de saída
    assign rx_data = rx_shift_reg;

endmodule