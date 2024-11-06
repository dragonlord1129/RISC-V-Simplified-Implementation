module instruction_fetch_unit (
    input clk,
    input reset,
    input [6:0] opcode,
    input [11:0] imm_address,
    input [11:0] imm_address_jmp,
    input jmp, branch,
    output reg [31:0] pc,
    output reg [31:0] current_pc
);

    // Regular PC increment (4 bytes)
    reg [31:0] next_pc;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0;
        end else begin
            if (branch) begin
                // If branching, set PC to immediate value
                pc <= {20'b0, imm_address}; // Branch address (adjust according to your system)
            end else begin
                // Otherwise, just increment PC
                next_pc = pc + 4;
                pc <= next_pc;
            end
        end
    end

    always @(posedge clk) begin
        current_pc <= pc;
    end

endmodule
