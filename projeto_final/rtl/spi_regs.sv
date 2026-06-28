`timescale 1ns / 1ps
module spi_regs (
    input  logic        clk,
    input  logic        rst,

    // Interface de Barramento de Sistema Estrita de 8 bits
    input  logic        write_en,
    input  logic        read_en,
    input  logic [2:0]  addr,
    input  logic [7:0]  write_data,
    output logic [7:0]  read_data,

    // Interface Interna para o Hardware da SPI
    output logic [1:0]  spi_mode,    // {CPOL, CPHA}
    output logic [15:0] clk_div,
    output logic [7:0]  tx_data,
    output logic        start,       // Pulso de 1 ciclo
    input  logic [7:0]  hw_rx_data,
    input  logic        hw_busy,
    input  logic        hw_done
);

    // Definição dos Offsets dos Registradores
    localparam ADDR_CTRL   = 3'b000;
    localparam ADDR_STATUS = 3'b001;
    localparam ADDR_CLK_LO = 3'b010;
    localparam ADDR_CLK_HI = 3'b011;
    localparam ADDR_TXDATA = 3'b100;
    localparam ADDR_RXDATA = 3'b101;

    // Registradores Internos de 8 bits
    logic [7:0] reg_ctrl;
    logic [7:0] reg_clk_lo;
    logic [7:0] reg_clk_hi;
    logic [7:0] reg_tx_data;
    logic [7:0] reg_rx_data;
    logic       reg_done_latch;

    // Conexões de saída extraindo os campos específicos
    assign spi_mode = reg_ctrl[2:1];
    assign clk_div  = {reg_clk_hi, reg_clk_lo}; 
    assign tx_data  = reg_tx_data;

    // Lógica de Escrita Síncrona
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            reg_ctrl    <= 8'h00;
            reg_clk_lo  <= 8'h04; // Valor default inferior seguro
            reg_clk_hi  <= 8'h00;
            reg_tx_data <= 8'h00;
            start       <= 1'b0;
        end else begin
            start <= 1'b0; 
            
            if (write_en) begin
                case (addr)
                    ADDR_CTRL: begin
                        // Bit 0: Enable, Bits 2:1: Mode
                        reg_ctrl[2:0] <= write_data[2:0];
                        
                        // Só dispara se o módulo estiver habilitado (Bit 0) e não estiver ocupado
                        if (write_data[3] && write_data[0] && !hw_busy) begin
                            start <= 1'b1;
                        end
                    end
                    ADDR_CLK_LO: begin
                        if (!hw_busy) reg_clk_lo <= write_data; // Proteção: impede alterar o clock em transmissão
                    end
                    ADDR_CLK_HI: begin
                        if (!hw_busy) reg_clk_hi <= write_data;
                    end
                    ADDR_TXDATA: begin
                        reg_tx_data <= write_data;
                    end
                    default: begin
                        // Registradores inválidos ou Read-Only ignoram a escrita
                    end
                endcase
            end
        end
    end

    // Lógica de Captura do Dado Recebido
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            reg_rx_data    <= 8'h00;
            reg_done_latch <= 1'b0;
        end else begin
            if (hw_done) begin
                reg_rx_data    <= hw_rx_data; // Armazena estaticamente o byte final
                reg_done_latch <= 1'b1;
            end else if (start || (read_en && addr == ADDR_STATUS)) begin
                reg_done_latch <= 1'b0;       // Limpa a flag ao iniciar nova transferência ou ao ler o status
            end
        end
    end

    // Lógica de Leitura Combinacional 
    always_comb begin
        read_data = 8'h00;
        if (read_en) begin
            case (addr)
                ADDR_CTRL: begin
                    read_data = {5'b00000, reg_ctrl[2:0]}; // Zera bits superiores não utilizados
                end
                ADDR_STATUS: begin
                    read_data = {6'b000000, reg_done_latch, hw_busy};
                end
                ADDR_CLK_LO: begin
                    read_data = reg_clk_lo;
                end
                ADDR_CLK_HI: begin
                    read_data = reg_clk_hi;
                end
                ADDR_TXDATA: begin
                    read_data = reg_tx_data;
                end
                ADDR_RXDATA: begin
                    read_data = reg_rx_data;
                end
                default: read_data = 8'h00;
            endcase
        end
    end

endmodule