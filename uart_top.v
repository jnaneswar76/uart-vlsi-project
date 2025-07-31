module uart_top (
    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,
    input rx,            // input from external line
    output tx,           // output to external line
    output [7:0] rx_data,
    output tx_done,
    output rx_done
);

    wire tick;

    baud_generator baud_inst (
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

    uart_tx tx_inst (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_done(tx_done)
    );

    uart_rx rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

endmodule
