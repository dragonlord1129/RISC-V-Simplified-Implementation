module instruction_fetch_unit (
    input clk, reset,
    input [31:0] opcode,
    input [11:0] imm_address,
    input [11:0] imm_address_jmp,
    input beq, bneq, blt, bltu, bge, bgeu, //Branch
    
    output reg [31:0] pc,
    output reg [31:0] current_pc
);
    always @(posedge clk) begin
        if(reset) pc <=0;
        else if (beq == 0 && bneq == 0 && blt == 0 && bltu == 0 && bge == 0 && bgeu == 0 & jmp == 0) begin
            pc <= pc + 4;
        end else if (beq == 0 || bneq == 0 || blt == 0 || bltu == 0 || bge == 0 || bgeu == 1 ) begin
            pc <= pc + imm_address;
        end else if(jmp) begin
            pc <= pc + imm_address_jmp;
        end
    end
    
    always @(posedge clk) begin
        if(reset) begin
            current_pc <= 0;
        end else if (reset == 0 && jmp == 0) begin
            current_pc <= current_pc + 4;
        end else begin
            current_pc <= current_pc;
        end
    end
endmodule