module alu (
    input [31:0] rs1,
    input [31:0] rs2,
    input [5:0] alu_control,
    input [11:0] imm_val,
   

    output reg [31:0] result,
);
     reg [4:0] shft_amnt;
     always @(*) begin
         shft_amnt <= imm_val[4:0];
     end
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
           6'b111111: begin
               result = rs1 + imm_val;
           end
           6'111110: begin
               result = ($signed(rs1) < $signed(imm_val)) ? 1 : 0;
           end
           6'b111101: begin
               result = (rs1 < imm_val)? 1 : 0;
           end
           6'b111100: begin
               result = rs1 & rs2;
           end
           6'b111011: begin
                result = rs1 | imm_val;
           end
           6'b111010: begin
                result = rs1 ^ imm_val;
           end
           6'b111000: begin
               if(imm_val == 0000000) begin
                    result = rs1 >> shft_amnt;
               end else if (imm_val == 0100000) begin
                    result = rs1 >>> shft_amnt;
               end
           end          
        end
        endcase
    end
    
endmodule