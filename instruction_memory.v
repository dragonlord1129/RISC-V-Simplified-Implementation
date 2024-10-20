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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        end
    end
endmodule