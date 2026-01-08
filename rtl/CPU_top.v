module CPU_top(
    input clk, rst
    );

    wire [31:0] PC_out;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] rs2_forward;
    wire [31:0] imm;
    wire [4:0] rd_addr;
    wire [31:0] Instruction;
    wire [31:0] PC_target;
    wire [31:0] ALU_result;
    wire [31:0] mem_data;
    wire Branch_taken;
    wire [31:0] rd_w_data;
    wire [3:0] alu_op;
    wire alu_src;
    wire jump;
    wire branch;
    wire jump_reg;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;

    fetch_stage FETCH (
        .clk (clk), // Inputs ....
        .rst (rst),
        .PC_in (PC_target),
        .PC_op (Branch_taken),
        .Instruction_out (Instruction), // Outputs ....
        .PC_out (PC_out)
    );

    ID_stage DECODE (
        .clk (clk), // Inputs ....
        .rst (rst),
        .instruction (Instruction),
        .rd_w_data (rd_w_data),
        .rs1_data (rs1_data), // Outputs ....
        .rs2_data (rs2_data),
        .imm (imm),
        .rd_addr (rd_addr),
        .alu_op (alu_op),
        .alu_src (alu_src),
        .mem_read (mem_read),
        .mem_write (mem_write),
        .mem_to_reg (mem_to_reg),
        .branch (branch),
        .jump (jump),
        .jump_reg (jump_reg)
    );

    EX_stage EXECUTE (
        .rs1_data (rs1_data), // Inputs ..... From ID
        .rs2_data (rs2_data), // From ID
        .imm (imm), // From ID
        .PC_out (PC_out), // From PC
        .alu_op (alu_op), // Control
        .alu_src (alu_src), // Control
        .branch (branch), // Control
        .jump (jump), // Control
        .jump_reg (jump_reg), // Control
        .ALU_result (ALU_result), // Outputs .... To MEM
        .rs2_forward (rs2_forward), // To MEM
        .PC_target (PC_target), // To PC_in ?
        .Branch_taken (Branch_taken) // Control
    );

    MEM_stage MEM (
        .clk (clk),
        .mem_read (mem_read), // Control
        .mem_write (mem_write), // Control
        .ALU_result (ALU_result), // From EX
        .rs2_forward (rs2_forward), // From EX
        .mem_data (mem_data) // to WB
    );

    WB_stage WB (
        .ALU_result (ALU_result), // Inputs ... 
        .mem_data (mem_data),
        .mem_to_reg (mem_to_reg),
        .rd_w_data (rd_w_data) // Outputs ... 
    );

endmodule