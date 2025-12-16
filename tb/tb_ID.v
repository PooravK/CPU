`timescale 1ns/1ps
`include "rtl/decoder_stage.v"

module tb_ID();
    reg [31:0]instruction;
    wire [4:0]rs1_addr;
    wire [4:0]rs2_addr;
    wire [4:0]rd_addr;
    wire [3:0]alu_op;
    wire reg_write;
    wire alu_src;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire branch;
    wire jump;
    wire jump_reg;

    decoder_stage uut (
        .instruction(instruction),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .alu_op(alu_op),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .jump(jump),
        .jump_reg(jump_reg)
    );

    initial begin
        $dumpfile("ID_waveform.vcd");
        $dumpvars(0, tb_ID);

        instruction = 32'h007302b3; // add x5, x6, x7 -> R type
        #10;
        instruction = 32'h00a48433; // add x8, x9, x10 -> R Type
        #10;
        instruction = 32'h00530293; // addi x5, x6, 5 -> I Type
        #10;
        instruction = 32'hfff10093; // addi x1, x2, -1 -> I type
        #10;
        instruction = 32'h0081a283; // lw x5, 8(x3) -> I Type
        #10;
        instruction = 32'h0040a623; // sw x4, 12(x1) -> S type
        #10;
        instruction = 32'h00208263; // beq x1, x2, 4 -> B type
        #10;
        instruction = 32'h008000ef; // jal x1, 8 -> J type
        #10;
        instruction = 32'h006200e7; // jalr x1, 6(x4) -> J type
        #10;
        instruction = 32'h123453b7; // lui x7, 0x12345 -> U type
        #10;
        instruction = 32'h00010197; // auipc x3, 0x10 -> U type
        #10;
        instruction = 32'h00000000; // Default
        #10;

        $finish;
    end
endmodule;