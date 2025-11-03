// Ye sab calculations perform karega
// Combinational design taaki fast rahe aur clock cycle ka wait na kare

module ALU(
    input signed [MAX_SIZE-1:0]in0, in1,
    input [2:0]ALU_op,
    output reg [MAX_SIZE-1:0]result,
    output zero_flag
    );

    parameter MAX_SIZE = 32;

    parameter ADD_op = 3'b000;
    parameter SUB_op = 3'b001;
    parameter AND_op = 3'b010;
    parameter OR_op = 3'b011;
    parameter XOR_op = 3'b100;
    parameter SLT_op = 3'b101;

    always @(*) begin
        case (ALU_op)
            ADD_op: result = in0 + in1;
            SUB_op: result = in0 - in1;
            AND_op: result = in0 & in1;
            OR_op: result = in0 | in1;
            XOR_op: result = in0 ^ in1;
            SLT_op: result = (in0 < in1)? 1:0;
            default: result = 0;
        endcase
    end

    assign zero_flag = (result == 0);
endmodule