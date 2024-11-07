module alu (
    input [31:0] rs1,
    input [31:0] rs2,
    input [5:0] alu_control,
    input [11:0] imm_val,
    output reg [31:0] result
);
    reg [4:0] shft_amnt;

    always @(*) begin
        shft_amnt = imm_val[4:0];
    end

    always @(*) begin
        case (alu_control)
            6'b000000: begin
                result = rs1 + rs2; // ADD operation
            end
            6'b000001: begin
                result = ($signed(rs1) < $signed(rs2)) ? 1 : 0; // SLT (signed comparison)
            end 
            6'b000010: begin
                result = (rs1 < rs2) ? 1 : 0; // SLTU (unsigned comparison)
            end
            6'b000011: begin
                result = rs1 & rs2; // AND
            end
            6'b000100: begin
                result = rs1 | rs2; // OR
            end
            6'b000101: begin
                result = rs1 ^ rs2; // XOR
            end
            6'b000110: begin
                result = rs1 << shft_amnt; // SLL (shift left logical)
            end
            6'b000111: begin
                result = rs1 >> shft_amnt; // SRL (shift right logical)
            end
            6'b001000: begin
                result = rs1 - rs2; // SUB
            end
            6'b001001: begin
                result = rs1 >>> shft_amnt; // SRA (shift right arithmetic)
            end
            6'b111111: begin
                result = rs1 + imm_val; // ADDI
            end
            6'b111110: begin
                result = ($signed(rs1) < $signed(imm_val)) ? 1 : 0; // SLTI
            end
            6'b111101: begin
                result = (rs1 < imm_val) ? 1 : 0; // SLTIU
            end
            6'b111100: begin
                result = rs1 & imm_val; // ANDI
            end
            6'b111011: begin
                result = rs1 | imm_val; // ORI
            end
            6'b111010: begin
                result = rs1 ^ imm_val; // XORI
            end
            6'b111000: begin
                if (imm_val[11:5] == 7'b0000000) begin
                    result = rs1 >> shft_amnt; // SRLI
                end else if (imm_val[11:5] == 7'b0100000) begin
                    result = rs1 >>> shft_amnt; // SRAI
                end else begin
                    result = 32'b0; // Default to 0 if imm_val doesn't match
                end
            end
            default: result = 32'b0; // Default case
        endcase
    end
    
endmodule
