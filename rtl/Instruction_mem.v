module Instruction_mem(
    input [31:0]PC_address,
    output [31:0]IM_instruction
    );

    reg [31:0]mem[255:0];

    assign IM_instruction = mem[PC_address[9:2]];

endmodule;

// Module purpose:
// Takes in the address provided by Program counter and outputs the instruction stored in that address
// Designed in combinational style so that as soon as PC address changes, it immediately outputs the latest instruction
// 32 bit registers, each with a length of 256 bits
// [9:2] since we use 32 bit register, next address is always incremented by 4 (8 x 4 = 32). Because of that initial 2 bits are always left out (00, 01, 10, 11)
// And since IM_instruction needs 8 bits of opcode, therefore next 8 bits are chosen from PC_address