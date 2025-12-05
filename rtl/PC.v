// Ye agle instruction ka memory address store karke rakhta hai 
// Clock cycle ke start me ye address instruction memory ko bhejta hai, instruction memory isse fetch karti hai ki kaunsa instruction stored hai is address par
// Fir ye instruction rest of the CPU ko send hota hai to be decoded and executed
// Kyuki ham 32 bits use kar rhe hai


module PC(
    input clk, rst,
    input [31:0]PC_in,
    input [1:0]PC_op,
    output reg [31:0]PC_out
    );

    parameter INCREAMENT = 2'b00;
    parameter LOAD = 2'b01;

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