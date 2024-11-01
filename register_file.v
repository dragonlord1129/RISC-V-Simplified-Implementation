module register_file (
    input clk, reset,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_data_dm,
    input lb, lui_control, jmp, sw,
    input [31:0] lui_imm_val,
    input [31:0] return_address,

    output [31:0] src1, src2,
    output [4:0] read_data_addr_dm,
    output reg [31:0] data_out_dm
);
    reg [31:0] reg_mem[31:0];
    integer i;

    assign read_data_addr_dm = rd;

    always @(posedge clk) begin
        if (reset) begin
            // Initialize all registers to 0 or to their index
            for (i = 0; i < 32; i = i + 1) begin
                reg_mem[i] = 0; 
            end
            data_out_dm = 0; // Reset data_out_dm
        end else begin
            if (lb) begin
                reg_mem[rd] = write_data_dm; // Load Byte
            end else if (sw) begin
                data_out_dm = reg_mem[rs1]; // Store Word
            end else if (lui_control) begin
                reg_mem[rd] = lui_imm_val; // Load Upper Immediate
            end else if (jmp) begin
                reg_mem[rd] = return_address; // Jump Address
            end
        end
    end

    // Combinational read for rs1 and rs2
    assign src1 = reg_mem[rs1];
    assign src2 = reg_mem[rs2];

endmodule
