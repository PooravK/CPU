`timescale 1ns/1ps
`include "rtl/decoder_stage.v"
`include "rtl/ImmediateGenerator.v"
`include "rtl/Reg32x32.v"
`include "rtl/ID_stage.v"

module tb_ID();
    reg [31:0]instruction;
    reg clk;
    reg rst;
    wire [31:0]rs1_data;
    wire [31:0]rs2_data;
    wire [31:0]imm;
    wire [4:0]rd_addr;

    ID_stage uut (
        .instruction(instruction),
        .clk(clk),
        .rst(rst),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm(imm),
        .rd_addr(rd_addr)
    );

    initial clk = 0;

    always #5 clk = ~clk;

    initial begin
        $dumpfile("ID_waveform.vcd");
        $dumpvars(0, tb_ID);

        rst = 1;
        instruction = 32'hFFFFFFFF;
        #12;

        rst = 0;
        #8;

        instruction = 32'h007302b3; // add x5, x6, x7 -> R type
        #20;
        instruction = 32'h00a48433; // add x8, x9, x10 -> R Type
        #20;
        instruction = 32'h00530293; // addi x5, x6, 5 -> I Type
        #20;
        instruction = 32'hfff10093; // addi x1, x2, -1 -> I type
        #20;
        instruction = 32'h0081a283; // lw x5, 8(x3) -> I Type
        #20;
        instruction = 32'h0040a623; // sw x4, 12(x1) -> S type
        #20;
        instruction = 32'h00208263; // beq x1, x2, 4 -> B type
        #20;
        instruction = 32'h008000ef; // jal x1, 8 -> J type
        #20;
        instruction = 32'h006200e7; // jalr x1, 6(x4) -> J type
        #20;
        instruction = 32'h123453b7; // lui x7, 0x12345 -> U type
        #20;
        instruction = 32'h00010197; // auipc x3, 0x10 -> U type
        #20;

        $finish;
    end
endmodule;