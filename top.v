module top (
    input clk,
    input reset,
    output [31:0] pc_out,
    output [31:0] alu_result
);

    // Wires and registers to connect submodules
    wire [31:0] pc, current_pc, instruction_code;
    wire [11:0] imm_address, imm_address_jmp;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;
    wire [5:0] alu_control;
    wire [31:0] src1, src2, effective_value, write_data_dm;
    wire [31:0] alu_output, data_out_dm;
    reg branch;
    wire beq, bneq, blt, bltu, bge, bgeu, lw, lwi, sw, jmp;

    // Instruction Fetch Unit
    instruction_fetch_unit IFU (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .imm_address(imm_address),
        .imm_address_jmp(imm_address_jmp),
        .jmp(jmp),
        .branch(branch),          // Pass branch signal to IFU
        .pc(pc),
        .current_pc(current_pc)
    );

    // Instruction Memory
    instruction_memory IMEM (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction_code(instruction_code)
    );

    // Decode instruction fields
    assign opcode = instruction_code[6:0];
    assign funct3 = instruction_code[14:12];
    assign funct7 = instruction_code[31:25];
    assign rs1 = instruction_code[19:15];
    assign rs2 = instruction_code[24:20];
    assign rd = instruction_code[11:7];
    assign imm_address = instruction_code[31:20];
    assign imm_address_jmp = instruction_code[31:20];

    // Control Unit
    control_unit CTRL (
        .reset(reset),
        .funct7(funct7),
        .funct3(funct3),
        .opcode(opcode),
        .alu_control(alu_control),
        .beq(beq),
        .bneq(bneq),
        .blt(blt),
        .bltu(bltu),
        .bge(bge),
        .bgeu(bgeu),
        .lw(lw),
        .lwi(lwi),
        .sw(sw),
        .jmp(jmp)
    );

    // ALU
    alu ALU (
        .rs1(src1),
        .rs2(src2),
        .alu_control(alu_control),
        .imm_val(imm_address), // Immediate value for ALU operations
        .result(alu_output)
    );

    // Register File
    register_file RF (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data_dm(write_data_dm),
        .lw(lw),
        .lwi(lwi),
        .jmp(jmp),
        .sw(sw),
        .lw_imm_val(imm_address),
        .return_address(pc),
        .src1(src1),
        .src2(src2),
        .read_data_addr_dm(rd),
        .data_out_dm(data_out_dm),
        .effective_value(effective_value)
    );

    // Output connections
    assign pc_out = pc;
    assign alu_result = alu_output;

    // Branch logic (only deciding whether a branch is taken)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            branch <= 1'b0; // Clear branch signal on reset
        end else begin
            // Set branch signal based on branch conditions
            branch <= (beq && (src1 == src2)) || 
                      (bneq && (src1 != src2)) || 
                      (blt && ($signed(src1) < $signed(src2))) || 
                      (bltu && (src1 < src2)) || 
                      (bge && ($signed(src1) >= $signed(src2))) || 
                      (bgeu && (src1 >= src2));
        end
    end

endmodule
