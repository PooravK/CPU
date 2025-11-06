`timescale 1ns/1ps

module tb_fetch_stage();
    reg clk;
    reg rst;
    reg [31:0]PC_in;
    reg [1:0]PC_op;
    wire [31:0]Instruction_out;
    wire [31:0]PC_out;

    fetch_stage uut (
        .clk(clk),
        .rst(rst),
        .PC_in(PC_in),
        .PC_op(PC_op),
        .Instruction_out(Instruction_out),
        .PC_out(PC_out)
        );

        initial clk = 1'b0;

        always #5 clk = ~clk;

        initial begin
            $dumpfile("fetch_stage_waveform.vcd");
            $dumpvars(0, tb_fetch_stage);

            rst = 1'b1;
            PC_op = 2'b00; //Increment
            PC_in = 32'h0000_0000;
            #12;
            rst = 1'b0;
            #8;

            PC_op = 2'b00; //Increment
            #20;

            PC_op = 2'b01; //Load
            PC_in = 32'h0000_0014;
            #10;

            PC_op = 2'b10; //Hold
            #10;

            PC_op = 2'b00; //Increament
            #20;

            PC_op = 2'b01; //Load
            PC_in = 32'h0000_00FC;
            #10;

            PC_op = 2'b00; //Increament
            #10;

            rst = 1'b1;
            #10;
            rst = 1'b0;
            #10;

            $finish;
        end
endmodule;