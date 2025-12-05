// Iska kaam hai ki ye PC ka diya hua address input lega, aur output karega ki us address pe kaunsa instruction stored hai
// Iska asynchronous hona critical hai taki jaise hi PC ka address change hota hai, isko immediately naya instruction output krna hai
 //32 bit registers jinki length 256 bits tak hai. Choosing 256 was purely a design choice. Width however was fixed at 32
  // Kyuki 32 bit register hai, to next address hamesha increament of 4 me aaega. To LSB ki 2 bits hamesha 00 rahengi. Now, 256 = 2^8 isliye we went from 2 to 9 

module Instruction_mem(
    input [31:0]PC_address,
    output [31:0]IM_instruction
    );

    reg [31:0]mem[255:0];

    assign IM_instruction = mem[PC_address[9:2]];

endmodule;