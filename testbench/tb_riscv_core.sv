`timescale 1ns / 1ps

module tb_riscv_core;
    logic clk;
    logic reset;

    // Instantiate the DUT
    riscv_core uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        $display("Starting RISC-V Processor Simulation...");

        // Initialize signals
        clk = 0;
        reset = 1;

        // Hold reset for a few cycles
        #20;
        reset = 0;

        // Let the processor run for a while
        #500;

        $display("Simulation Finished.");
        $finish;
    end

endmodule
