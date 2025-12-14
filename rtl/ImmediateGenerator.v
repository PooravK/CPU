module ImmediateGenerator(
    input [31:0]instruction, // Took from instruction memory
    output reg [31:0]imm // Given to ALU etc
    );

    wire [6:0]instruct_type = instruction[6:0]; // 7 Bits because thats the way RISC-V are designed. TO scale, this provides 128 different operations to add.
    // I am going to use the classic op code mapping:

    parameter OP_IMM = 7'b0010011;
    parameter LOAD = 7'b0000011;
    parameter JALR = 7'b1100111;
    parameter STORE = 7'b0100011;
    parameter BRANCH = 7'b1100011;
    parameter LUI = 7'b0110111;
    parameter AUIPC = 7'b0010111;
    parameter JAL = 7'b1101111;
    parameter OP = 7'b0110011;

    always @(*)begin
        imm = 0; // I did this for safety reasonds
        case (instruct_type)
        OP_IMM: begin // I Type
            imm[11:0] = instruction[31:20]; // I did all the assigning using the op code table provided in official RISC-V documents
            imm[31:12] = {20{instruction[31]}}; // Sign extension
        end
        LOAD: begin // I Type
            imm[11:0] = instruction[31:20];
            imm[31:12] = {20{instruction[31]}};
        end
        JALR: begin // I Type
            imm[11:0] = instruction[31:20];
            imm[31:12] = {20{instruction[31]}};
        end
        STORE: begin // S Type
            imm[11:5] = instruction[31:25];
            imm[4:0] = instruction[11:7];
            imm[31:12] = {20{instruction[31]}};
        end
        BRANCH: begin // B Type
            imm[12] = instruction[31];
            imm[10:5] = instruction[30:25];
            imm[4:1] = instruction[11:8];
            imm[11] = instruction[7];
            imm[31:13] = {19{instruction[31]}};
            imm = imm << 1; // Shifted because B and J type instructions store addresses in units of 2 bytes instead of 1.
        end
        LUI: imm[31:12] = instruction[31:12]; // U Type
        AUIPC: imm[31:12] = instruction[31:12]; // U Type
        JAL: begin // J Type
            imm[20] = instruction[31];
            imm[10:1] = instruction[30:21];
            imm[11] = instruction[20];
            imm[19:12] = instruction[19:12];
            imm[31:21] = {11{instruction[31]}};
        end
        default: imm = 0; // R Type
        endcase
    end
endmodule;

// Module purpose:
// Extracts and constructs 32 bit signed immediate values from a 32-bit instruction
// Purely combinational