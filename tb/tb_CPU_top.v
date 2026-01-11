`timescale 1ns/1ps

`include "rtl/fetch_stage.v"
`include "rtl/Instruction_mem.v"
`include "rtl/PC.v"
`include "rtl/ID_stage.v"
`include "rtl/decoder_stage.v"
`include "rtl/ImmediateGenerator.v"
`include "rtl/Reg32x32.v"
`include "rtl/EX_stage.v"
`include "rtl/ALU.v"
`include "rtl/MEM_stage.v"
`include "rtl/WB_stage.v"
`include "rtl/CPU_top.v"

module tb_CPU_top ();
    reg rst;
    reg clk;

    CPU_top uut (
        .rst(rst),
        .clk(clk)
    );

    initial clk = 1'b0;

    always #20 clk = ~clk;

    initial begin
        $dumpfile("CPU_waveform.vcd");
        $dumpvars(0, tb_CPU_top);

        rst = 1;
        #20;

        uut.FETCH.Instruction_module.mem[0] = 32'h00a00093;
        uut.FETCH.Instruction_module.mem[1] = 32'h00300113;
        uut.FETCH.Instruction_module.mem[2] = 32'h002081b3;
        uut.FETCH.Instruction_module.mem[3] = 32'h40208233;
        uut.FETCH.Instruction_module.mem[4] = 32'h0020f2b3;
        uut.FETCH.Instruction_module.mem[5] = 32'h0020e333;
        uut.FETCH.Instruction_module.mem[6] = 32'h0020c3b3;
        #20;

        rst = 0;
        #300;

        $finish;
    end
endmodule;