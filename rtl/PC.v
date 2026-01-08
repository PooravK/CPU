module PC(
    input clk, rst,
    input [31:0]PC_in,
    input PC_op,
    output reg [31:0]PC_out
    );

    parameter INCREAMENT = 1'b0;
    parameter LOAD = 1'b1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PC_out <= 0;
        end else begin
            case (PC_op)
                INCREAMENT: PC_out <= PC_out + 4;
                LOAD: PC_out <= PC_in;
                default: PC_out <= PC_out;
            endcase
        end
    end
endmodule;

// Module Purpose:
// Stores the address of the next instruction to be performed
// Sends this instruction to instruction memory on every rising clock pulse
// THree tasks:
// 1) Increament (By 4 because of 32 bit design (8 x 4 = 32))
// 2) Load (Output the current input)
// 3) Stall (Nothing changes in output)