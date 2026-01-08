module ID_stage(
    input [31:0]instruction,
    input [31:0]rd_w_data,
    input clk, rst,
    output [31:0]rs1_data, rs2_data, imm,
    output [4:0]rd_addr,
    output [3:0] alu_op,
    output alu_src, mem_read, mem_write, mem_to_reg, branch, jump, jump_reg
    );

    wire reg_write;

    wire [4:0]rs1_addr_decoder;
    wire [4:0]rs2_addr_decoder;
    wire [4:0]rd_addr_decoder;   

    assign rd_addr = rd_addr_decoder;

    Reg32x32 REGISTER(
        .clk(clk),
        .rst(rst),
        .rs1_addr(rs1_addr_decoder),
        .rs2_addr(rs2_addr_decoder),
        .rd_addr(rd_addr_decoder),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .rd_we(reg_write),
        .rd_wdata(rd_w_data)
    );
    decoder_stage DECODER(
        .instruction(instruction),
        .rs1_addr(rs1_addr_decoder),
        .rs2_addr(rs2_addr_decoder),
        .rd_addr(rd_addr_decoder),
        .alu_op(alu_op),
        .reg_write (reg_write),
        .alu_src (alu_src),
        .mem_read (mem_read),
        .mem_write (mem_write),
        .mem_to_reg (mem_to_reg),
        .branch (branch),
        .jump (jump),
        .jump_reg (jump_reg)
    );
    ImmediateGenerator IMM_GENERATOR(
        .instruction(instruction),
        .imm(imm)
    );
endmodule;