`timescale 1ns/1ps
`include "rtl/ImmediateGenerator.v"

module tb_IG();
    reg [31:0]instruction;
    wire [31:0]imm;

    ImmediateGenerator uut (
        .instruction(instruction),
        .imm(imm)
    );

    initial begin
        $dumpfile("IG_waveform.vcd");
        $dumpvars(0, tb_IG);

        instruction = 32'h00a10093; // addi x1 x2 10
        #20;

        instruction = 32'hfff10093; // addi x1 x2 -1
        #20;

        instruction = 32'hfe322c23; // sw x3, -8(x4)
        #20;

        instruction = 32'hfe208ee3; // beq x1, x2, -4
        #20;
        
        instruction = 32'h00208463; // beq x1, x2, 8
        #20;

        instruction = 32'h123452b7; // lui x5, 0x12345
        #20;

        instruction = 32'h008000ef; // jal x1, 8
        #20;

        instruction = 32'hff9ff0ef; // jal x1, -8
        #20;
        $finish;
    end
endmodule;