// Iska bas ek purpose hai, to connect PC and Instruction memory together
// Ye address jump or branch me load hoga
// Instruction jo fetch hua hai, this will come from IM_Instruction
// Current instruction ka address

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