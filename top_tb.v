`timescale 1ns / 1ps

module top_tb;
    // Declare signals to connect to the top module
    reg clk;
    reg reset;
    wire [31:0] pc_out;
    wire [31:0] alu_result;

    // Instantiate the top module
    top uut (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock with 10 ns period
    end

    // Reset and stimulus
    initial begin
        // Dumpfile for GTKWave
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        // Initialize signals
        reset = 1;
        #10;
        reset = 0;

        // Insert additional stimulus here as needed

        #1000; // Run simulation for some time
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | PC Out=%h | ALU Result=%h", $time, pc_out, alu_result);
    end
endmodule
