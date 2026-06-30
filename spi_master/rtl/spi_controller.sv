`timescale 1ns / 1ps
module spi_controller (
    input  logic clk,
    input  logic rst,

    // Sinais de Interface Interna
    input  logic start,       // Pulso vindo do spi_regs
    input  logic bit_cnt_max, // Flag vinda do datapath (8 bits transferidos)
    output logic clk_en,      // Liga o spi_clk_gen
    output logic load_en,     // Carrega o datapath com TX_DATA
    output logic shift_en,    // Habilita deslocamento no datapath
    output logic done,        // Avisa o spi_regs que terminou

    // Pino Físico
    output logic spi_cs_n     // Chip Select (Ativo em Baixa)
);

    typedef enum logic [1:0] {
        IDLE,
        LOAD,
        TRANSFER,
        DONE
    } state_t;

    state_t state, next_state;

    // Lógica Síncrona de Estado
    always_ff @(posedge clk) begin
        if (!rst) state <= IDLE;
        else        state <= next_state;
    end

    // Lógica Combinacional de Próximo Estado e Saídas
    always_comb begin
        // Valores default
        next_state = state;
        clk_en     = 1'b0;
        load_en    = 1'b0;
        shift_en   = 1'b0;
        spi_cs_n   = 1'b1; // CS Inativo (Alto)
        done       = 1'b0;

        case (state)
            IDLE: begin
                if (start) next_state = LOAD;
            end

            LOAD: begin
                spi_cs_n = 1'b0; // Abaixa o CS
                load_en  = 1'b1; // Manda o datapath carregar os dados
                next_state = TRANSFER;
            end

            TRANSFER: begin
                spi_cs_n = 1'b0; // Mantém o CS baixo
                clk_en   = 1'b1; // Liga o gerador de clock
                shift_en = 1'b1; // Habilita a escuta dos "ticks" no datapath
                
                // Aguarda a flag do datapath indicando que todos os bits foram
                if (bit_cnt_max) next_state = DONE;
            end

            DONE: begin
                spi_cs_n = 1'b1; // Levanta o CS
                done     = 1'b1; // Pulso de conclusão para o banco de registradores
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule