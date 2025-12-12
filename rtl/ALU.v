module ALU(
    input [31:0]in0, in1,
    input [3:0]ALU_op,
    output reg [31:0]result,
    output zero_flag
    );

    parameter ADD_op = 4'b0000;
    parameter SUB_op = 4'b0001;
    parameter AND_op = 4'b0010;
    parameter OR_op = 4'b0011;
    parameter XOR_op = 4'b0100;
    parameter SLTU_op = 4'b0101;
    parameter SLT_op = 4'b0110;
    parameter SLL_op = 4'b0111;
    parameter SRL_op = 4'b1000;
    parameter SRA_op = 4'b1001;

    always @(*) begin
        case (ALU_op)
            ADD_op: result = in0 + in1;
            SUB_op: result = in0 - in1;
            AND_op: result = in0 & in1;
            OR_op: result = in0 | in1;
            XOR_op: result = in0 ^ in1;
            SLT_op: result = ($signed(in0) < $signed(in1))? 1:0;
            SLTU_op: result = (in0 <in1)?1:0;
            SLL_op: result = in0 << in1[4:0];
            SRL_op: result = in0 >> in1[4:0];
            SRA_op: result = $signed(in0) >>> in1[4:0];
            default: result = 0;
        endcase
    end

    assign zero_flag = (result == 0);
endmodule

// Module Purpose:
// Performs all calculations
// Designed in combinational style so that it does not depend on clock and provides immediate results