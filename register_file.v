module register_file (
    input clk, reset,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_data_dm, // Data coming from memory
    input lw, lwi, jmp, sw,
    input [11:0] lw_imm_val, // Immediate offset for load word
    input [31:0] return_address,
    input beq, bneq, blt, bltu, bge, bgeu,

    output [31:0] src1, src2,
    output [4:0] read_data_addr_dm,
    output reg [31:0] data_out_dm,
    output [31:0] effective_value // Effective address output for memory
);
    reg [31:0] reg_mem[31:0];
    integer i;
    reg branch;

    assign read_data_addr_dm = rd;
    assign effective_value = reg_mem[rs1] + {{20{lw_imm_val[11]}}, lw_imm_val}; // Sign-extend lw_imm_val to 32 bits

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize all registers to 0
            for (i = 0; i < 32; i = i + 1) begin
                reg_mem[i] <= 32'b0;
            end
            data_out_dm <= 32'b0; // Reset data_out_dm
            branch <= 1'b0;
        end else begin
            // Load Word
            if (lw) begin
                reg_mem[rd] <= write_data_dm; // Load from memory to register
            end

            // Store Word
            if (sw) begin
                data_out_dm <= reg_mem[rs1]; // Store the value in src1 to data_out_dm
            end 

            // Load Immediate
            if (lwi) begin
                reg_mem[rd] <= effective_value; // Load immediate address directly
            end 

            // Jump Operation
            if (jmp) begin
                reg_mem[rd] <= return_address; // Store the jump return address in rd
            end
        end
    end

    // Combinational read for rs1 and rs2
    assign src1 = reg_mem[rs1];
    assign src2 = reg_mem[rs2];

endmodule
