module instruction_memory (
    input  logic [31:0] addr,
    output logic [31:0] instruction
);
    logic [31:0] memory [0:255];

    initial begin
        // Example: addi x1, x0, 10
        memory[0] = 32'h00a00093;  // addi x1, x0, 10
        memory[1] = 32'h00100113;  // addi x2, x0, 1
        // Add more instructions here
    end

    assign instruction = memory[addr[9:2]];  // word aligned
endmodule
