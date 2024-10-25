module register_file (
    input clk, reset,
    input [4:0] rs1, rs2,
    input [4:0] rd,
    input [31:0] write_data_dm,
    input lb, lui_control,
    input jmp, sw,
    input [31:0] lui_imm_val,
    input [31:0] return_address,

    output [31:0] read_data1, read_data2,
    output [4:0] read_data_addr_dm,
    output reg [31:0] data_out_dm
);
    reg [31:0] reg_mem[31:0];
    wire [31:0] write_reg_dm;
    integer i;

    assign read_data_addr_dm = rd;
    assign write_reg_dm = rd;

    always @(posedge clk) begin
        if(reset) begin
            for(i=0; i<32; i=i+1) begin
                reg_mem[i] = i;
                data_out_dm = 0;
            end
        end else begin
            if (lb) begin
                reg_mem[rd] = write_data_dm; // rd is address in decimal units it goes from 0 to 31; hence if some 'rd' location is necessary then, so is provided
            else if (sw) begin
                    data_out_dm = reg_mem[rs1];
                end
            else if (lui_control) begin
                    reg_mem[rd] = lui_imm_val;
                end
            else if (jmp) begin
                    reg_mem[rd] = imm_address;
                end
            end
        end
    end

    assign read_data1 = reg_mem[rs1];
    assign read_data2 = reg_mem[rs2];

endmodule