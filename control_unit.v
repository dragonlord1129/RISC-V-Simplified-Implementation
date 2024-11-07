module control_unit (
    input reset,
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,

    output reg [5:0] alu_control, // ALU control signal
    output reg beq, bneq, blt, bltu, bge, bgeu, // Branch control signals
    output reg lw, lwi, sw, // Load and Store signals
    output reg jmp // Jump signal
);

    // Parameters for instruction types
    parameter R_type = 7'b0110011;
    parameter I_type = 7'b1001100;
    parameter Control_Transfer_Load_Store = 7'b1010101;

    // Reset handling for ALU control signal
    always @(posedge reset) begin
        if (reset)
            alu_control = 6'b000000;
    end

    // Main control logic
    always @(*) begin
        // Default control signal values
        alu_control = 6'b000000;
        beq = 0;
        bneq = 0;
        blt = 0;
        bltu = 0;
        bge = 0;
        bgeu = 0;
        lw = 0;
        lwi = 0;
        sw = 0;
        jmp = 0;

        case (opcode)
            // R-type operations
            R_type: begin
                case (funct7)
                    7'b0000000: begin
                        case (funct3)
                            3'b000: alu_control = 6'b000000; // ADD
                            3'b001: alu_control = 6'b000001; // SLT
                            3'b010: alu_control = 6'b000010; // SLTU
                            3'b011: alu_control = 6'b000011; // AND
                            3'b100: alu_control = 6'b000100; // OR
                            3'b101: alu_control = 6'b000101; // XOR
                            3'b110: alu_control = 6'b000110; // SLL
                            3'b111: alu_control = 6'b000111; // SRL
                            default: ;
                        endcase
                    end
                    7'b0100000: begin
                        case (funct3)
                            3'b010: alu_control = 6'b001000; // SUB
                            3'b011: alu_control = 6'b001001; // SRA
                            default: ;
                        endcase
                    end
                    default: ;
                endcase
            end

            // I-type operations
            I_type: begin
                case (funct3)
                    3'b000: alu_control = 6'b111111; // ADDI
                    3'b001: alu_control = 6'b111110; // SLTI
                    3'b010: alu_control = 6'b111101; // SLTUI
                    3'b011: alu_control = 6'b111100; // ANDI
                    3'b100: alu_control = 6'b111011; // ORI
                    3'b101: alu_control = 6'b111010; // XORI
                    3'b110: alu_control = 6'b111001; // SLLI
                    3'b111: alu_control = 6'b111000; // SRLI or SRAI
                    default: ;
                endcase
            end

            // Control Transfer, Load, and Store operations
            Control_Transfer_Load_Store: begin
                case (funct3)
                    3'b000: jmp = 1'b1;       // Jump
                    3'b001: beq = 1'b1;       // BEQ
                    3'b010: bneq = 1'b1;      // BNEQ
                    3'b011: blt = 1'b1;       // BLT
                    3'b100: bltu = 1'b1;      // BLTU
                    3'b101: bge = 1'b1;       // BGE
                    3'b110: bgeu = 1'b1;      // BGEU
                    3'b111: begin
                        case (funct7)
                            7'b1111111: lwi = 1'b1; // Load Word Immediate
                            7'b0001000: sw = 1'b1;  // Store Word
                            7'b0000000: lw = 1'b1;  // Load Word
                            default: ;
                        endcase
                    end
                    default: ;
                endcase
            end
            
            default: ;
        endcase
    end
endmodule
