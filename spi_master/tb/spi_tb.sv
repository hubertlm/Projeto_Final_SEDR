`timescale 1ns / 1ps

module spi_tb;

    // Sinais de Sistema
    logic clk;
    logic rst;

    // Sinais do Barramento de Sistema 
    logic       bus_write_en;
    logic       bus_read_en;
    logic [2:0] bus_addr;
    logic [7:0] bus_write_data;
    logic [7:0] bus_read_data;

    // Sinais Físicos da SPI
    logic spi_sclk;
    logic spi_mosi;
    logic spi_miso;
    logic spi_cs_n;

    // Offsets dos Registradores 
    localparam ADDR_CTRL   = 3'b000;
    localparam ADDR_STATUS = 3'b001;
    localparam ADDR_CLK_LO = 3'b010;
    localparam ADDR_CLK_HI = 3'b011;
    localparam ADDR_TXDATA = 3'b100;
    localparam ADDR_RXDATA = 3'b101;

    // Instanciação do Módulo Topo 
    spi_top dut (
        .clk            (clk),
        .rst            (rst),
        .write_en       (bus_write_en),
        .read_en        (bus_read_en),
        .addr           (bus_addr),
        .write_data     (bus_write_data),
        .read_data      (bus_read_data),
        .spi_sclk       (spi_sclk),
        .spi_mosi       (spi_mosi),
        .spi_miso       (spi_miso),
        .spi_cs_n       (spi_cs_n)
    );

    // Geração de Clock (50 MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Simula a CPU escrevendo em um registrador
    task write_reg(input [2:0] addr, input [7:0] data);
        begin
            @(posedge clk);
            bus_addr       <= addr;
            bus_write_data <= data;
            bus_write_en   <= 1'b1;
            @(posedge clk);
            bus_write_en   <= 1'b0;
            bus_addr       <= 3'd0;
            bus_write_data <= 8'd0;
        end
    endtask

    // Simula a CPU lendo de um registrador
    task read_reg(input [2:0] addr, output [7:0] data_out);
        begin
            @(posedge clk);
            bus_addr    <= addr;
            bus_read_en <= 1'b1;
            @(posedge clk);
            data_out    = bus_read_data; // Amostra o dado
            bus_read_en <= 1'b0;
        end
    endtask
    
    // Simula um sensor ou módulo externo enviando dados no MISO
    // Configurado para Mode 0 (CPOL=0, CPHA=0)
    task mock_spi_slave_loopback(input [7:0] mock_tx);
        integer i;
        begin
            spi_miso = mock_tx[7]; // Pré-carga do MSB antes do primeiro clock
            @(negedge spi_cs_n);   // Aguarda o Master baixar o CS
            
            for (i = 6; i >= 0; i = i - 1) begin
                @(negedge spi_sclk); // Mode 0: Shift na borda de descida
                spi_miso = mock_tx[i];
            end
        end
    endtask
    
    logic [7:0] read_val;

    initial begin
        // Inicialização e Reset
        rst          = 1'b0;
        bus_write_en   = 1'b0;
        bus_read_en    = 1'b0;
        bus_addr       = 3'b000;
        bus_write_data = 8'h00;
        spi_miso       = 1'b0;
        
        #50 rst = 1'b1;
        #20;

        $display("[TIME: %0t] Configurando Registradores...", $time);
        
        // Configura Divisor de Clock (Ex: Divisor = 4)
        write_reg(ADDR_CLK_LO, 8'h04);
        write_reg(ADDR_CLK_HI, 8'h00);

        // Prepara a Transação (Dados e Modo)
        // Dado a enviar: 0x5A (01011010)
        write_reg(ADDR_TXDATA, 8'h5A);
        
        // Habilita a SPI no Modo 0 (Enable = bit 0, Mode = bits 2:1)
        write_reg(ADDR_CTRL, 8'b0000_0001); 
        
        $display("[TIME: %0t] Disparando Transação SPI...", $time);

        // Dispara uma thread paralela para o Escravo responder
        // O escravo responderá com 0xC3 (11000011)
        fork
            mock_spi_slave_loopback(8'hC3);
        join_none

        // Inicia a Transação (Mantém Enable e Modo, levanta bit 3 de Start)
        write_reg(ADDR_CTRL, 8'b0000_1001);

        // Polling de Status (Simula Firmware aguardando a interrupção/flag)
        read_val = 8'h00;
        while ((read_val & 8'h02) == 8'h00) begin // Verifica o bit 1 
            read_reg(ADDR_STATUS, read_val);
            #50; // Aguarda antes de consultar novamente
        end

        $display("[TIME: %0t] Transação Concluída. Lendo RX DATA...", $time);

        // Lê o dado recebido
        read_reg(ADDR_RXDATA, read_val);
        
        // Validação Objetiva
        if (read_val == 8'hC3) begin
            $display(">>> TESTE PASSOU! Dado recebido: 0x%h", read_val);
        end else begin
            $display(">>> TESTE FALHOU! Esperado: 0xC3, Recebido: 0x%h", read_val);
        end

        #100
        $finish;
    end

endmodule