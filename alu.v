module alu (
    input [31:0] rs1,
    input [31:0] rs2,
    input [5:0] alu_control,
    input [31:0] imm_val,
    input [31:0] shft_amnt,// shift amount

    output reg [31:0] result
);
    always @(*) begin
        case(alu_control) begin
           6'b000000: begin
                result = rs1 + rs2;
           end
           6'b000001: begin
                result = ($signed(rs1) < $signed(rs2)) ? 1 : 0;
           end 
           6'b000010: begin
                result = (rs1 < rs2)? 1 : 0;
           end
           6'b000011; begin
                result = rs1 & rs2;
           end
           6'b000100: begin
                result = rs1 | rs2;
           end
           6'b000101: begin
                result = rs1 ^ rs2;
           end
           6'b000110: begin
                result = rs1 << rs2;
           end
           6'b000111: begin
                result = rs1 >> rs2;
           end
           6'b001000: begin
                reset = rs1 - rs2;
           end
           6'b001001: begin
                result = rs1 >>> rs2;
           end  
        end
        endcase
    end
    
endmodule