`timescale 1ns/1ps
`include "rtl/EX_stage.v"
`include "rtl/ALU.v"

module tb_EX();
    reg [31:0]rs1_data;
    reg [31:0]rs2_data;
    reg [31:0]imm;
    reg [31:0]PC_out;

    reg [3:0]alu_op;

    reg alu_src;
    reg jump;
    reg branch;
    reg jump_reg;

    wire [31:0] ALU_result;
    wire [31:0] rs2_forward;
    wire [31:0] PC_target;

    wire Branch_taken;

    EX_stage uut (
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm(imm),
        .PC_out(PC_out),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .jump(jump),
        .branch(branch),
        .jump_reg(jump_reg),
        .ALU_result(ALU_result),
        .rs2_forward(rs2_forward),
        .PC_target(PC_target),
        .Branch_taken(Branch_taken)    
    );

    initial begin
        $dumpfile("EX_waveform.vcd");
        $dumpvars(0, tb_EX);


        // R type
        rs1_data = 10;
        rs2_data = 7;
        alu_src = 0;
        alu_op = 4'b0000; // ADD
        branch = 0;
        jump = 0;
        jump_reg = 0;
        PC_out = 100;
        #20;

        // I type
        alu_src = 1;
        imm = 5;
        #20;

        // Branch not taken
        imm = 16;
        alu_src = 0;
        alu_op = 4'b0001; // SUB
        branch = 1;
        #20;

        // Branch taken
        rs2_data = 10; // 10 - 10 = 0
        #20;

        // JAL
        imm = 32;
        jump = 1;
        PC_out = 100;
        #20;

        // JALR
        rs1_data = 200;
        imm = 12;
        jump_reg = 1;
        jump = 0;
        branch = 0;
        #20;

        // Priority test
        imm = 8;
        branch = 1;
        jump = 1;
        PC_out = 50;
        rs1_data = 5;
        rs2_data = 5;
        #20;

        //Default case
        branch = 0;
        jump = 0;
        jump_reg = 0;
        PC_out = 32;
        #20;

        $finish;
    end
endmodule;
