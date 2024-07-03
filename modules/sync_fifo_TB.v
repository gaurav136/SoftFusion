`timescale 1ns / 1ps

module sync_fifo_TB;

    // Clock and reset signals
    reg clk;
    reg rst;

    // FIFO signals
    reg wr_en;
    reg rd_en;
    reg [31:0] data_in;
    wire [31:0] data_out;
    wire empty;
    wire full;

    // Instantiate the FIFO
    synchronous_fifo uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty),
        .full(full)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        data_in = 32'd0;

        // Reset the FIFO
        #10;
        rst = 0;

        // Write some data to the FIFO
        #10;
        wr_en = 1;
        data_in = 32'hA1A1A1A1;
        #10;
        data_in = 32'hB2B2B2B2;
        #10;
        data_in = 32'hC3C3C3C3;
        #10;
        data_in = 32'hD4D4D4D4;
        #10;
        data_in = 32'hE5E5E5E5;
        #10;
        data_in = 32'hF6F6F6F6;
        #10;
        data_in = 32'h07070707;
        #10;
        data_in = 32'h08080808;
        #10;
        wr_en = 0;

        // Wait a few cycles
        #20;

        // Read data from the FIFO
        rd_en = 1;
        #10;
        rd_en = 0;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;

        // Finish the simulation
        #20;
        $finish;
    end

    initial begin
        // Monitor signals
        $monitor("Time = %0t, wr_en = %b, rd_en = %b, data_in = %h, data_out = %h, empty = %b, full = %b", 
                  $time, wr_en, rd_en, data_in, data_out, empty, full);
    end

endmodule
