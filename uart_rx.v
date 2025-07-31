module uart_rx(
    input clk,
    input rst,
    input rx,
    output reg [7:0] rx_data,
    output reg rx_done
);
    parameter BAUD_TICK_COUNT = 10416;
    parameter IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, DONE = 3'b100;

    reg [2:0] state = IDLE;
    reg [13:0] baud_cnt = 0;
    reg [2:0] bit_idx = 0;
    reg [7:0] data_buf = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            rx_data <= 0;
            rx_done <= 0;
            baud_cnt <= 0;
            bit_idx <= 0;
        end else begin
            case (state)
                IDLE: begin
                    rx_done <= 0;
                    if (~rx) state <= START;
                end
                START: begin
                    if (baud_cnt < (BAUD_TICK_COUNT >> 1)) baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        state <= DATA;
                    end
                end
                DATA: begin
                    if (baud_cnt < BAUD_TICK_COUNT) baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        data_buf[bit_idx] <= rx;
                        if (bit_idx < 7) bit_idx <= bit_idx + 1;
                        else begin
                            bit_idx <= 0;
                            state <= STOP;
                        end
                    end
                end
                STOP: begin
                    if (baud_cnt < BAUD_TICK_COUNT) baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        state <= DONE;
                    end
                end
                DONE: begin
                    rx_data <= data_buf;
                    rx_done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
