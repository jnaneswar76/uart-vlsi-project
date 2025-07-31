module baud_generator (
    input clk,
    input rst,
    output reg tick
);
    parameter BAUD_TICK_COUNT = 10416; // For 9600 baud at 100 MHz
    reg [13:0] count = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            tick <= 0;
        end else if (count == BAUD_TICK_COUNT - 1) begin
            count <= 0;
            tick <= 1;
        end else begin
            count <= count + 1;
            tick <= 0;
        end
    end
endmodule
