module synchronous_fifo (input wire clk,
                         input wire rst,
                         input wire wr_en,
                         input wire rd_en,
                         input wire [31:0] data_in,
                         output reg [31:0] data_out,
                         output wire empty,
                         output wire full);
    
    // Define the depth of the FIFO
    parameter DEPTH = 8;
    parameter WIDTH = 32;
    
    // Memory array for the FIFO
    reg [WIDTH-1:0] fifo_mem [0:DEPTH-1];
    
    // Write and read pointers
    reg [2:0] wr_ptr = 0;
    reg [2:0] rd_ptr = 0;
    
    // FIFO status flags
    reg [3:0] fifo_cnt = 0; // Counter to track the number of elements in the FIFO
    
    // Output assignments for empty and full signals
    assign empty = (fifo_cnt == 0);
    assign full  = (fifo_cnt == DEPTH);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset pointers and count
            wr_ptr   <= 0;
            rd_ptr   <= 0;
            fifo_cnt <= 0;
            end else begin
            // Write operation
            if (wr_en && !full) begin
                fifo_mem[wr_ptr] <= data_in;
                wr_ptr           <= wr_ptr + 1;
                fifo_cnt         <= fifo_cnt + 1;
            end
            
            // Read operation
            if (rd_en && !empty) begin
                data_out <= fifo_mem[rd_ptr];
                rd_ptr   <= rd_ptr + 1;
                fifo_cnt <= fifo_cnt - 1;
            end
        end
    end
    
endmodule
