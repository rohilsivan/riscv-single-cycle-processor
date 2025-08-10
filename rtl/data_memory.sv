module data_memory (
    input  logic clk,
    input  logic [31:0] addr,
    input  logic [31:0] write_data,
    input  logic mem_read,
    input  logic mem_write,
    output logic [31:0] read_data
);
    logic [31:0] memory [0:255];

    always_ff @(posedge clk) begin
        if (mem_write)
            memory[addr[9:2]] <= write_data;
    end

    assign read_data = mem_read ? memory[addr[9:2]] : 32'd0;
endmodule
