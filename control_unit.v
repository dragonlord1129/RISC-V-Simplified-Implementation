module control_unit (
    input reset,
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,

    output reg [5:0] alu_control, //ALU
    output reg beq, bneq, blt, bltu, bge, bgeu, //Branch
    output reg lb, lui, sw, // Load and Store
    output reg jmp
);
    parameter R-type = 7'b0110011;
    parameter I-type1 = 7'b1001100;
    parameter I-type2 = 7'b1001101;

    always @(reset) begin
        if(reset) alu_control = 0;
    end    
    always @(funct7 or funct3 or opcode) begin
        case (opcode)
            R-type: begin //////////////// R-type operation ////////////////////////
                case(funct7)
                  7'b0000000: begin
                    case (funct3)
                        3'b000: begin
                            alu_control = 6'b000000; // ADD operation
                        end
                        3'b001: begin
                            alu_control = 6'b000001; // SLT operation
                        end
                        3'b010: begin
                            alu_control = 6'b000010; // SLTU operation
                        end
                        3'b011: begin
                            alu_control = 6'b000011; // AND operation
                        end
                        3'b100: begin
                            alu_control = 6'b000100; // OR operation
                        end
                        3'b101: begin
                            alu_control = 6'b000101; // XOR operation
                        end
                        3'b110: begin
                            alu_control = 6'b000110; // SLL operation
                        end
                        3'b111: begin
                            alu_control = 6'b000111; // SRL operation
                        end
                        default : ;                            
                    endcase
                    7'b0100000: begin
                        case (funct3)
                            3'b010: begin
                                alu_control = 6'b001000; // SUB operation
                            end
                            3'011: begin
                                alu_control = 6'b001001; // SRA operation
                            end
                            default: ;  
                        endcase
                    end
                  end  
                endcase
            end 
/////////////////////////////////I-type/////////////////////////////////
            I-type: begin
                case(funct3)
                    3'b000: begin
                            alu_control = 6'b111111; // ADDI operation
                        end
                        3'b001: begin
                            alu_control = 6'b111110; // SLTI operation
                        end
                        3'b010: begin
                            alu_control = 6'b111101; // SLTUI operation
                        end
                        3'b011: begin
                            alu_control = 6'111100; // ANDI operation
                        end
                        3'b100: begin
                            alu_control = 6'b111011; // ORI operation
                        end
                        3'b101: begin
                            alu_control = 6'b111010; // XORI operation
                        end
                        3'b110: begin
                            alu_control = 6'b111001; // SLLI operation
                        end
                        3'b111: begin
                            alu_control = 6'b111000; // SRLI operation
                        end
                        default : ; 
                endcase
            end
            I-type2: begin
                case(funct3)
                    3'b111: begin
                        alu_control = 6'b101010; // SRAI operation 
                    end
                endcase
            end
            default: ;

        endcase
    end
endmodule