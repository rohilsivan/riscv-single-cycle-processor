module alu_control (
    input  logic [1:0] alu_op,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [3:0] alu_control
);

    always_comb begin
        case (alu_op)
            2'b00: alu_control = 4'b0010; // ADD (lw/sw/addi)
            2'b01: alu_control = 4'b0110; // SUB (branch)
            2'b10: begin // R-type
                case ({funct7, funct3})
                    10'b0000000000: alu_control = 4'b0010; // ADD
                    10'b0100000000: alu_control = 4'b0110; // SUB
                    10'b0000000111: alu_control = 4'b0000; // AND
                    10'b0000000110: alu_control = 4'b0001; // OR
                    10'b0000000100: alu_control = 4'b1100; // XOR
                    default:        alu_control = 4'b1111;
                endcase
            end
            default: alu_control = 4'b0000;
        endcase
    end
endmodule
