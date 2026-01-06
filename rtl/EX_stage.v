module EX_stage(
    input [31:0]
        rs1_data, // from ID
        rs2_data,  // from ID
        imm, // from IG
        PC_out, // from IF
    input [3:0]
        alu_op, // from Decoder
    input
        alu_src, 
        branch, 
        jump, 
        jump_reg,
    output [31:0]
        ALU_result, // Result of ALU
        rs2_forward, // Value of rs2 will be forwarded to MEM stage
    output reg [31:0]
        PC_target,
    output reg
        Branch_taken // Whioch branch to be taken
    );

    wire [31:0] PC_plus_4;
    wire [31:0] PC_branch;
    wire [31:0] PC_jump;
    wire [31:0] PC_jump_reg;

    reg [31:0] second_im1;

    wire ALU_flag;

    assign PC_plus_4 = PC_out + 4;
    assign PC_branch = PC_out + imm;
    assign PC_jump = PC_out + imm;
    assign PC_jump_reg = rs1_data + imm;

    assign rs2_forward = rs2_data;

    always @(*)begin
        case(alu_src)
            1'b1: second_im1 = imm;
            1'b0: second_im1 = rs2_data;
        endcase
    end

    always @(*)begin
        Branch_taken = 0;
        PC_target = PC_plus_4;

        if (jump_reg)begin
            PC_target = PC_jump_reg;
            Branch_taken = 1;
        end else if (jump)begin
            PC_target = PC_jump;
            Branch_taken = 1;
        end else if (branch && ALU_flag)begin
            PC_target = PC_branch;
            Branch_taken = 1;
        end
    end

    ALU ALU_Block (
        .in0(rs1_data),
        .in1(second_im1),
        .ALU_op(alu_op),
        .result(ALU_result),
        .zero_flag(ALU_flag)
    );
endmodule;