module alu (
    input  logic [31:0] a, b,
    input  logic [3:0] alu_control,
    output logic [31:0] result
);
    always_comb begin
        case (alu_control)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0110: result = a - b;
            4'b0111: result = (a < b) ? 32'd1 : 32'd0;
            4'b1100: result = a ^ b;
            default: result = 32'd0;
        endcase
    end
endmodule
