// Iska bas ek purpose hai, to connect PC and Instruction memory together

module fetch_stage (
    input clk, rst,
    input [31:0]PC_in, // Ye address jump or branch me load hoga
    input [1:0]PC_op,
    output [31:0]Instruction_out, // Instruction jo fetch hua hai, this will come from IM_Instruction
    output [31:0]PC_out, // Current instruction ka address 
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