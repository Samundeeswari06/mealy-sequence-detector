// Code your testbench here
// or browse Examples
module tb_mealy_1011_detector;
    reg clk, reset, x;
    wire y;

    mealy_1011_detector uut (
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end

    // Input sequence
    initial begin
        $display("Time\tX\tY");
        $monitor("%0t\t%b\t%b", $time, x, y);

        reset = 1; x = 0; #10;
        reset = 0;

        x = 1; #10;  // 1
        x = 0; #10;  // 10
        x = 1; #10;  // 101
        x = 1; #10;  // 1011 => Output should be 1 here
        x = 1; #10;
        x = 0; #10;
        x = 1; #10;
        x = 1; #10;  // 1011 again

        $finish;
    end
endmodule
