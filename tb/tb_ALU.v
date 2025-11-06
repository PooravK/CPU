`timescale 1ns/1ps

module tb_ALU();
    reg [31:0]in0;
    reg [31:0]in1;
    reg [3:0]ALU_op;
    wire [31:0]result;
    wire zero_flag;

    ALU uut (
        .in0(in0),
        .in1(in1),
        .ALU_op(ALU_op),
        .result(result),
        .zero_flag(zero_flag)
        );

        initial begin
            $dumpfile("ALU_Waveform.vcd");
            $dumpvars(0, tb_ALU);

            ALU_op = 4'b0000; //Addition
            in0 = 32'h7FFFFFFF;
            in1 = 32'd1;
            #10;
            in0 = 32'hFFFFFFFF;
            in1 = 32'd1;
            #10;
            in0 = 32'h80000000;
            in1 = 32'h80000000;
            #10;

            ALU_op = 4'b0001; //Subtraction
            in0 = 32'h00000000;
            in1 = 32'h00000001;
            #10;
            in0 = 32'h80000000;
            in1 = 32'h00000001;
            #10;
            in0 = 32'h7FFFFFFF;
            in1 = 32'hFFFFFFFF;
            #10;
            ALU_op = 4'b0010; //AND
            in0 = 32'hFFFFFFFF;
            in1 = 32'h00000000;
            #10;
            in0 = 32'hAAAAAAAA;
            in1 = 32'h55555555;
            #10;
            in0 = 32'hF0F0F0F0;
            in1 = 32'h0F0F0F0F;
            #10;
            ALU_op = 4'b0011; //OR
            in0 = 32'hFFFFFFFF;
            in1 = 32'h00000000;
            #10;
            in0 = 32'hAAAAAAAA;
            in1 = 32'h55555555;
            #10;
            in0 = 32'hF0F0F0F0;
            in1 = 32'h0F0F0F0F;
            #10;
            ALU_op = 4'b0100; //XOR
            in0 = 32'hFFFFFFFF;
            in1 = 32'h00000000;
            #10;
            in0 = 32'hAAAAAAAA;
            in1 = 32'h55555555;
            #10;
            in0 = 32'hF0F0F0F0;
            in1 = 32'h0F0F0F0F;
            #10;
            ALU_op = 4'b0101; //SLTU
            in0 = 32'h00000001;
            in1 = 32'h00000002;
            #10;
            in0 = 32'hFFFFFFFF;
            in1 = 32'h00000001;
            #10;
            in0 = 32'h7FFFFFFF;
            in1 = 32'h80000000;
            #10;
            ALU_op = 4'b0110; //SLT
            in0 = 32'h00000001;
            in1 = 32'h00000002;
            #10;
            in0 = 32'hFFFFFFFF;
            in1 = 32'h00000001;
            #10;
            in0 = 32'h80000000;
            in1 = 32'h7FFFFFFF;
            #10;
            ALU_op = 4'b0111; //SLL
            in0 = 32'h00000001;
            in1 = 32'h00000002;
            #10;
            in0 = 32'h00000001;
            in1 = 32'h00000000;
            #10;
            in0 = 32'hF0000000;
            in1 = 32'h0F000000;
            #10;
            ALU_op = 4'b1000; //SRL
            in0 = 32'h80000000;
            in1 = 32'hC0000000;
            #10;
            in0 = 32'h00000001;
            in1 = 32'h00000000;
            #10;
            in0 = 32'hF0000000;
            in1 = 32'h0F000000;
            #10;
            ALU_op = 4'b1001; //SRA
            in0 = 32'h80000000;
            in1 = 32'hC0000000;
            #10;
            in0 = 32'hFFFFFFFF;
            in1 = 32'hFFFFFFFF;
            #10;
            in0 = 32'hF0000000;
            in1 = 32'hFF000000;
            #10;
            $finish;
        end
endmodule;