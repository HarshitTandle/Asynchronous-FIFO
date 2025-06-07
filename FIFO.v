module FIFO(
    input [31:0] dataIn,
    input clk,
    input enable,
    input read,
    input write,
    input rst,
    output reg empty,
    output reg full,
    output reg [31:0] dataOut
);

    reg [31:0] A [7:0];  
    reg [2:0] write_ptr = 0;
    reg [2:0] read_ptr =0;

      

    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            write_ptr <= 0;
            read_ptr<=0;
            empty <= 1;
            full <= 0;
        end 
        else if (enable) 
        begin
            
            if (write && !full)
            begin
                A[write_ptr] <= dataIn;
                write_ptr <= write_ptr + 1;     
            end

            full <= (write_ptr == 8);
            empty <= (write_ptr == 0);
        end
        end
        
        always @(posedge clk or posedge rst) 
        begin
        if (rst) 
        begin
            write_ptr <= 0;
            read_ptr<=0;
            empty <= 1;
            full <= 0;
        end 
        else if (enable) 
        begin
            
            if(read && !empty)
            begin
                    dataOut <= A[read_ptr];
                read_ptr <= read_ptr + 1;
            end
        end
        end
endmodule


