module control_unit (
    input  logic [6:0] opcode,
    output logic reg_write,
    output logic alu_src,
    output logic mem_to_reg,
    output logic mem_read,
    output logic mem_write,
    output logic [1:0] alu_op,
    output logic branch
);

    always_comb begin
        case (opcode)
            7'b0110011: begin // R-type
                alu_src     = 0;
                mem_to_reg  = 0;
                reg_write   = 1;
                mem_read    = 0;
                mem_write   = 0;
                branch      = 0;
                alu_op      = 2'b10;
            end
            7'b0010011: begin // I-type (addi)
                alu_src     = 1;
                mem_to_reg  = 0;
                reg_write   = 1;
                mem_read    = 0;
                mem_write   = 0;
                branch      = 0;
                alu_op      = 2'b00;
            end
            7'b0000011: begin // Load
                alu_src     = 1;
                mem_to_reg  = 1;
                reg_write   = 1;
                mem_read    = 1;
                mem_write   = 0;
                branch      = 0;
                alu_op      = 2'b00;
            end
            7'b0100011: begin // Store
                alu_src     = 1;
                mem_to_reg  = 0; // X
                reg_write   = 0;
                mem_read    = 0;
                mem_write   = 1;
                branch      = 0;
                alu_op      = 2'b00;
            end
            7'b1100011: begin // Branch
                alu_src     = 0;
                mem_to_reg  = 0;
                reg_write   = 0;
                mem_read    = 0;
                mem_write   = 0;
                branch      = 1;
                alu_op      = 2'b01;
            end
            default: begin
                alu_src     = 0;
                mem_to_reg  = 0;
                reg_write   = 0;
                mem_read    = 0;
                mem_write   = 0;
                branch      = 0;
                alu_op      = 2'b00;
            end
        endcase
    end
endmodule
