`timescale 1ns / 1ps

module uart_tb;

    reg clk = 0;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire [7:0] rx_data;
    wire tx_done, rx_done;

    // Simulate external RX line
    wire rx;
    assign rx = tx;  // loopback: transmitter output wired to receiver input

    // Instantiate the top-level UART module
    uart_top uut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .rx(rx),
        .tx(tx),
        .rx_data(rx_data),
        .tx_done(tx_done),
        .rx_done(rx_done)
    );

    // Generate clock (100 MHz = 10ns period)
    always #5 clk = ~clk;

    initial begin
        // 💾 Dumping waveform info
        $dumpfile("waveform.vcd");
        $dumpvars(0, uart_tb);

        // Initialization
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;
        #100;
        
        rst = 0;
        #50;

        // Send byte 0xA5
        tx_data = 8'hA5;
        tx_start = 1;
        #10;
        tx_start = 0;

        // Wait for transmission and reception to complete
        wait (tx_done);
        $display("TX Done.");

        wait (rx_done);
        $display("RX Done. Received Byte = %h", rx_data);

        #100;
        $finish;
    end

endmodule
