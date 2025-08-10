module register_file (
    input  logic clk,
    input  logic [4:0] rs1, rs2, rd,
    input  logic [31:0] write_data,
    input  logic reg_write,
    output logic [31:0] data1, data2
);
    logic [31:0] registers [0:31];

    always_ff @(posedge clk) begin
        if (reg_write && rd != 0)
            registers[rd] <= write_data;
    end

    assign data1 = registers[rs1];
    assign data2 = registers[rs2];
endmodule
