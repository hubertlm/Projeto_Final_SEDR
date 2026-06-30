`timescale 1ns / 1ps
module spi_top (
    // Sinais de Sistema
    input  logic       clk,
    input  logic       rst,

    // Interface de Barramento 
    input  logic       write_en,
    input  logic       read_en,
    input  logic [2:0] addr,
    input  logic [7:0] write_data,
    output logic [7:0] read_data,

    // Interface Física SPI
    output logic       spi_sclk,
    output logic       spi_mosi,
    input  logic       spi_miso,
    output logic       spi_cs_n
);

    // Sinais entre Registradores e os outros módulos
    logic [1:0]  spi_mode;
    logic [15:0] clk_div;
    logic [7:0]  tx_data;
    logic [7:0]  rx_data;
    logic        start;
    logic        done;
    logic        hw_busy;

    // Sinais entre FSM e Datapath / Clock Gen
    logic        clk_en;
    logic        load_en;
    logic        shift_en;
    logic        bit_cnt_max;

    // Ticks do Clock Gen para o Datapath
    logic        sample_edge;
    logic        shift_edge;

    // A SPI está ocupada sempre que o Chip Select estiver ativo (em nível baixo)
    assign hw_busy = ~spi_cs_n;

    // Módulo de Registradores (Interface de 8 bits)
    spi_regs u_regs (
        .clk            (clk),
        .rst            (rst),
        .write_en       (write_en),
        .read_en        (read_en),
        .addr           (addr),
        .write_data     (write_data),
        .read_data      (read_data),
        
        .spi_mode       (spi_mode),
        .clk_div        (clk_div),
        .tx_data        (tx_data),
        .start          (start),
        .hw_rx_data     (rx_data),
        .hw_busy        (hw_busy),
        .hw_done        (done)
    );

    // Módulo Gerador de Base de Tempo
    spi_clk_gen u_clk_gen (
        .clk            (clk),
        .rst            (rst),
        .en             (clk_en),
        .clk_div        (clk_div),
        .spi_mode       (spi_mode),
        
        .spi_sclk       (spi_sclk),
        .sample_edge    (sample_edge),
        .shift_edge     (shift_edge)
    );

    // Módulo de Caminho de Dados (Datapath)
    spi_data u_datapath (
        .clk            (clk),
        .rst            (rst),
        .tx_data        (tx_data),
        .rx_data        (rx_data),
        
        .load_en        (load_en),
        .shift_en       (shift_en),
        .bit_cnt_max    (bit_cnt_max),
        
        .sample_edge    (sample_edge),
        .shift_edge     (shift_edge),
        
        .spi_mosi       (spi_mosi),
        .spi_miso       (spi_miso)
    );

    // Módulo Controlador (Máquina de Estados)
    spi_controller u_fsm (
        .clk            (clk),
        .rst            (rst),
        .start          (start),
        .bit_cnt_max    (bit_cnt_max),
        
        .clk_en         (clk_en),
        .load_en        (load_en),
        .shift_en       (shift_en),
        .done           (done),
        .spi_cs_n       (spi_cs_n)
    );

endmodule