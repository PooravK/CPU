`timescale 1ns/1ps
`include "rtl/Reg32x32.v"

module tb_reg();
    reg clk;
    reg rst;
    reg rd_we;
    reg [4:0] rs1_addr;
    reg [4:0] rs2_addr;
    reg [4:0] rd_addr;
    reg [31:0] rd_wdata;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;

    Reg32x32 uut (
        .clk(clk),
        .rst(rst),
        .rd_we(rd_we),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_wdata(rd_wdata),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    initial clk = 0;

    always #5 clk = ~clk;

    initial begin
        $dumpfile("reg_waveform.vcd");
        $dumpvars(0, tb_reg);

        rst = 1;
        rd_we = 0;
        rs1_addr = 0;
        rs2_addr = 0;
        rd_addr = 0;
        rd_wdata = 0;
        rs1_data = 0;
        rs2_data = 0;
        #12;

        rst = 0;
        #8;

        
    end
endmodule