module ID_stage(
    input [31:0]instruction,
    input clk, rst,
    output [31:0]rs1_data, rs2_data, imm,
    output [4:0]rd_addr
    );

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
        .rd_we(1'b0),
        .rd_wdata(0)
    );
    decoder_stage DECODER(
        .instruction(instruction),
        .rs1_addr(rs1_addr_decoder),
        .rs2_addr(rs2_addr_decoder),
        .rd_addr(rd_addr_decoder)
    );
    ImmediateGenerator IMM_GENERATOR(
        .instruction(instruction),
        .imm(imm)
    );
endmodule;