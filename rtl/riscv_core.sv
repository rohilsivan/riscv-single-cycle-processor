module riscv_core (
    input logic clk,
    input logic reset
);
    logic [31:0] pc, next_pc;
    logic [31:0] instr;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] reg_data1, reg_data2, alu_result, imm;
    logic [31:0] write_data;
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic reg_write, alu_src, mem_to_reg, mem_read, mem_write, branch;
    logic [1:0] alu_op;
    logic [3:0] alu_control;
    logic [31:0] mem_read_data;

    // Fetch 
    pc_register pc_reg (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );
    instruction_memory imem (
        .addr(pc),
        .instruction(instr)
    );

    // Decode 
    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1    = instr[19:15];
    assign rs2    = instr[24:20];
    assign funct7 = instr[31:25];

    register_file rf (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .data1(reg_data1),
        .data2(reg_data2)
    );

    immediate_generator imm_gen (
        .instr(instr),
        .imm_out(imm)
    );

    alu alu_unit (
        .a(reg_data1),
        .b(alu_src ? imm : reg_data2),
        .alu_control(alu_control),
        .result(alu_result)
    );

    data_memory dmem (
        .clk(clk),
        .addr(alu_result),
        .write_data(reg_data2),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .read_data(mem_read_data)
    );

    control_unit control (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_op(alu_op),
        .branch(branch)
    );

    alu_control alu_ctrl (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control)
    );

    assign write_data = mem_to_reg ? mem_read_data : alu_result;
    assign next_pc = pc + 4;  // Basic PC increment; to be replaced with branch logic

endmodule
