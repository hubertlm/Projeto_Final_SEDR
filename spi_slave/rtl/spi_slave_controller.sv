module spi_slave_controller (
    input  logic clk, 
    input  logic rst,
    input  logic sclk_rise, 
    input  logic sclk_fall,
    input  logic cs_n_sync,
    output logic shift_en,
    output logic load_en,
    output logic done
);

    typedef enum logic [1:0] {IDLE, TRANSFER, DONE} state_t;
    state_t state, next_state;
    logic [3:0] bit_cnt;

    // FSM de controle
    always_ff @(posedge clk) begin
        if (rst) state <= IDLE;
        else       state <= next_state;
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE:     if (!cs_n_sync) next_state = TRANSFER;
            TRANSFER: if (cs_n_sync)  next_state = IDLE;
                      else if (bit_cnt == 4'd8) next_state = DONE;
            DONE:     if (cs_n_sync)  next_state = IDLE;
            default:  next_state = IDLE;
        endcase
    end

    // Lógica de saídas e contagem
    always_ff @(posedge clk) begin
        if (rst || cs_n_sync) begin
            bit_cnt <= 4'd0;
            shift_en <= 1'b0;
            done <= 1'b0;
        end else begin
            shift_en <= sclk_rise;
            if (sclk_rise) begin
                bit_cnt <= bit_cnt + 1'b1;
                if (bit_cnt == 4'd7) done <= 1'b1;
            end
        end
    end
endmodule