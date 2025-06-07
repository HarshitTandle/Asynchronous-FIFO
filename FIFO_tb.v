
module FIFO_tb;

   
    reg [31:0] dataIn;
    reg clk;
    reg enable;
    reg read;
    reg write;
    reg rst;

    wire empty;
    wire full;
    wire [31:0] dataOut;

   
    FIFO uut (
        .dataIn(dataIn),
        .clk(clk),
        .enable(enable),
        .read(read),
        .write(write),
        .rst(rst),
        .empty(empty),
        .full(full),
        .dataOut(dataOut)
    );

  
    always #5 clk = ~clk; 

    initial begin
       
        clk = 0;
        rst = 1;
        enable = 0;
        write = 0;
        read = 0;
        dataIn = 32'd0;
	
	#10;
        rst = 0;
        enable = 1;

        @(posedge clk);
        dataIn = 32'hA5A5_FF00; 
        write = 1;

        @(posedge clk);
        dataIn = 32'h1234_ABCD;  
        write = 1;

        @(posedge clk);
        write = 0;
        #50;

        repeat (8) 
        begin
            @(posedge clk);
            read = 1;
        end

        @(posedge clk);
        read = 0;

        $finish;
    end
endmodule