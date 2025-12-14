module decoder_stage(
    input [31:0]
        instruction, // Taken from isntruction ememory
    output [4:0]
        rs1_addr,
        rs2_addr, 
        rd_addr,
    output reg [3:0]
        alu_op, // Which action to perform
    output reg
        reg_write, // 1: write
        alu_src, // 0: uses rs2 adder v/s 1: uses imm value
        mem_read, // 1: read from data memory
        mem_write, // 1: write to data memory
        mem_to_reg, // What gets written into rd, 0: ALU output or 1: data memory output
        branch, // 1: conditional branch
        jump, // 1: unconditional jump
        jump_reg // 1: jump depends on register
    );

    wire [6:0]op_code;
    wire [2:0]funct3;
    wire [6:0]funct7;

    // Based on official specificaitons:
    assign op_code = instruction[6:0];
    assign rd_addr = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign funct7 = instruction[31:25];

    // same as my immediate generator
    parameter OP_IMM = 7'b0010011;
    parameter LOAD = 7'b0000011;
    parameter JALR = 7'b1100111;
    parameter STORE = 7'b0100011;
    parameter BRANCH = 7'b1100011;
    parameter LUI = 7'b0110111;
    parameter AUIPC = 7'b0010111;
    parameter JAL = 7'b1101111;
    parameter OP = 7'b0110011;

    // control decisions now:
    always @(*)begin
        reg_write = 0;
        alu_src = 0;
        alu_op = 0;
        mem_read = 0;
        mem_write = 0;
        mem_to_reg = 0;
        branch = 0;
        jump = 0;
        jump_reg = 0;
        case (op_code)
            OP: begin
                reg_write = 1; // read rs1 rs2 and writw the redult to rd
            end
            OP_IMM: begin
                reg_write = 1; // write resukt into rd
                alu_src = 1; // use imm value
            end
            LOAD: begin // alu compute address = rs1 + imm
                reg_write = 1; // write result into rd
                alu_src = 1; // use imm value
                mem_read = 1; // read value at memory 
                mem_to_reg = 1; // data memory output gets written into rd
            end
            STORE: begin
                alu_src = 1; // use imm
                mem_write = 1; // write into data memory
            end
            BRANCH: begin
                branch = 1; // conditional pc update by comparing rs1 and rs2
            end
            JAL: begin
                reg_write = 1; // write ot rd
                alu_src = 1; // use imm value
                jump = 1; // unconditional jump
            end
            JALR: begin
                reg_write = 1; // give PC + 4 to rd
                alu_src = 1; // use imm
                jump_reg = 1;
            end
            LUI: begin
                reg_write = 1; // rd = imm << 12
                alu_src = 1;
            end
            AUIPC: begin // rd = PC + (imm << 12)
                reg_write = 1;
                alu_src = 1;
            end
        endcase
    end
endmodule;

// Module Purpose:
// Takes in a 32 bit instruction and generates register addresses and control signals for ALU, PC, Memory and Register file
// Decides what an instruction means, not it's execution