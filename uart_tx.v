module uart_tx(
    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,
    output reg tx,
    output reg tx_done
);
    parameter BAUD_TICK_COUNT = 10416; // 9600 baud for 100 MHz
    parameter IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, DONE = 3'b100;

    reg [2:0] state = IDLE;
    reg [13:0] baud_cnt = 0;
    reg [2:0] bit_idx = 0;
    reg [7:0] data_buf = 8'b0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;
            baud_cnt <= 0;
            bit_idx <= 0;
            tx_done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    tx_done <= 0;
                    if (tx_start) begin
                        state <= START;
                        data_buf <= tx_data;
                    end
                end
                START: begin
                    tx <= 1'b0;
                    if (baud_cnt < BAUD_TICK_COUNT) baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        state <= DATA;
                    end
                end
                DATA: begin
                    tx <= data_buf[bit_idx];
                    if (baud_cnt < BAUD_TICK_COUNT) baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        if (bit_idx < 7) bit_idx <= bit_idx + 1;
                        else begin
                            bit_idx <= 0;
                            state <= STOP;
                        end
                    end
                end
                STOP: begin
                    tx <= 1'b1;
                    if (baud_cnt < BAUD_TICK_COUNT) baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        state <= DONE;
                    end
                end
                DONE: begin
                    tx_done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
