module fetch_stage (
    input clk, rst,
    input [31:0]PC_in,
    input [1:0]PC_op,
    output [31:0]Instruction_out,
    output [31:0]PC_out
    );

    PC PC_module (
        .clk(clk),
        .rst(rst),
        .PC_in(PC_in),
        .PC_op(PC_op),
        .PC_out(PC_out)
        );
    Instruction_mem Instruction_module (
        .IM_instruction(Instruction_out),
        .PC_address(PC_out)
        );
endmodule

// Module purpose:
// Acts as a wrapper for Program Counter and Instruction Memory
// This address will be loaded into jump/branch