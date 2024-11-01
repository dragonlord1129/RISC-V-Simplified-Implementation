module instruction_memory (
    input clk, reset,
    input [31:0] pc,

    output [31:0] instruction_code
);
    reg [8:0] memory [127:0]; 
    assign instruction_code <= {memory[pc+3], memory[pc+2], memory[pc+1], memory[pc]};

    always @(posedge clk ) begin
        if (reset) begin
//////////////////////////////////////////////////////Integer R-Type Instructions//////////////////////////////////////////////////////////
/*  In this implementation of RISC-V in the given code, integer register operations are carried out by x1, x2, and x3 registers
    where operands for operation are x1 and x2 and destination to store the result is x3.
            register mapping x1 = 5'b00001
                             x2 = 5'b00010
                             x3 = 5'b00011
            funct3:  ADD  = 000
                     SLT  = 001
                     SLTU = 010
                     AND  = 011
                     OR   = 100
                     XOR  = 101
                     SLL  = 110
                     SRL  = 111
Hence the instruction becomes  (0000 000)(0 0010) (0000 1)(000 - 111) (0001 1)(011 0011) -> (funct7)(src2)(src1)(funct3)(rd)(opcode)

Similarly for the R-type instruction SUB and SLA
funct7 = 0100 000 and 
           funct3:   SUB  = 010
                     SLA  = 011
Hence the instruction becomes  (0100 000)(0 0010) (0000 1)(000 - 111) (0001 1)(011 0011) -> (funct7)(src2)(src1)(funct3)(rd)(opcode)
*/
              
// ADD = 0x002081B3 
           memory[3] = 8'h00;
           memory[2] = 8'h20;
           memory[1] = 8'h81;
           memory[0] = 8'hB3;

//  SLT = 0x002091B3        
            memory[7] = 8'h00;
            memory[6] = 8'h20;
            memory[5] = 8'h91;
            memory[4] = 8'hB3;

// SLTU = 0x0020A1B3
            memory[11] = 8'h00;
            memory[10] = 8'h20;
            memory[9] = 8'hA1;
            memory[8] = 8'hB3;

// AND = 0x0020B1B3
            memory[15] = 8'h00;
            memory[14] = 8'h20;
            memory[13] = 8'hB1;
            memory[12] = 8'hB3;

// OR = 0x0020C1B3
            memory[19] = 8'h00;
            memory[18] = 8'h20;
            memory[17] = 8'hC1;
            memory[16] = 8'hB3;

// XOR = 0x0020D1B3
            memory[23] = 8'h00;
            memory[22] = 8'h20;
            memory[21] = 8'hD1;
            memory[20] = 8'hB3;

// SLL = 0x0020E1B3

            memory[27] = 8'h00;
            memory[26] = 8'h20;
            memory[25] = 8'hE1;
            memory[24] = 8'hB3;

// SRL = 0x0020F1B3
            memory[31] = 8'h00;
            memory[30] = 8'h20;
            memory[29] = 8'hF1;
            memory[28] = 8'hB3;

// SUB = 0x4020A1B3
            memory[35] = 8'h40;
            memory[34] = 8'h20;
            memory[33] = 8'hA1;
            memory[32] = 8'hB3;

// SRA = 0x4020B1B3
            memory[39] = 8'h40;
            memory[38] = 8'h20;
            memory[37] = 8'hB1;
            memory[36] = 8'hB3;
/////////////////////////Integer R-type///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////Integer I-type////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
    In this implementation of I-type we use register x4, and x5 as src and destination respectively
        register mapping:
            x4 = 00100;
            x5 = 00101;
            
            funct3:  ADDI  = 000
                     SLTI  = 001
                     SLTUI = 010
                     ANDI  = 011
                     ORI   = 100
                     XORI  = 101
                     SLLI  = 110
                     SRLI/SRAI  = 111 (depends on the immediate value)
*/
// ADDI = 0x000202CC
            memory[43] = 8'h00;
            memory[42] = 8'h02;
            memory[41] = 8'h02;
            memory[40] = 8'hCC;

// SLTI = 0x000212CC
            memory[47] = 8'h00;
            memory[46] = 8'h02;
            memory[45] = 8'h12;
            memory[44] = 8'hCC;
// SLTUI = 0x000222CC 
            memory[51] = 8'h00;
            memory[50] = 8'h02;
            memory[49] = 8'h22;
            memory[48] = 8'hCC;
// ANDI = 0x000232CC
            memory[55] = 8'h00;
            memory[54] = 8'h02;
            memory[53] = 8'h32;
            memory[52] = 8'hCC;
// ORI = 0x000242CC
            memory[59] = 8'h00;
            memory[58] = 8'h02;
            memory[57] = 8'h42;
            memory[56] = 8'hCC;
// XORI = 0x000252CC
            memory[63] = 8'h00;
            memory[62] = 8'h02;
            memory[61] = 8'h52;
            memory[60] = 8'hCC;
// SLLI = 0x000262CC
            memory[67] = 8'h00;
            memory[66] = 8'h02;
            memory[65] = 8'h62;
            memory[64] = 8'hCC;
// SRLI = 0x000272CC
            memory[71] = 8'h00;
            memory[70] = 8'h02;
            memory[69] = 8'h72;
            memory[68] = 8'hCC;
// SRAI = 0x000272CD
            memory[71] = 8'h00;
            memory[70] = 8'h02;
            memory[69] = 8'h72;
            memory[68] = 8'hCD;
//////////////////////////Control Transfer Instructions//////////////
// JALR = 0x002080C5
            memory[75] = 8'h00;
            memory[74] = 8'h00;
            memory[73] = 8'h81;
            memory[72] = 8'h55;
// BEQ = 0x00009155
            memory[79] = 8'h00;
            memory[78] = 8'h00;
            memory[77] = 8'h91;
            memory[76] = 8'h55;
// BNEQ = 0x0000A155
            memory[83] = 8'h00;
            memory[82] = 8'h00;
            memory[81] = 8'hA1;
            memory[80] = 8'h55;
// BLT = 0x0000B155
            memory[87] = 8'h00;
            memory[86] = 8'h00;
            memory[85] = 8'hB1;
            memory[84] = 8'h55;
// BLTU = 0x0000C155
            memory[91] = 8'h00;
            memory[90] = 8'h00;
            memory[89] = 8'hC1;
            memory[88] = 8'h55;
// BGE = 0x0000D155
            memory[95] = 8'h00;
            memory[94] = 8'h00;
            memory[93] = 8'hD1;
            memory[92] = 8'h55;
// BGEU = 0x0000E155
            memory[99] = 8'h00;
            memory[98] = 8'h00;
            memory[97] = 8'hE1;
            memory[96] = 8'h55;
        end
    end
endmodule