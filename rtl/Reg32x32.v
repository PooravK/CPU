module Reg32x32(
    input clk, rst, rd_we, // Write enable
    input [4:0] rs1_addr, rs2_addr, // Address of register sources 1 and 2. 5 bits because 2^5 = 32 so we need 5 bit op code
    input [4:0] rd_addr, // Register to be written on
    input [31:0] rd_wdata, // Write data
    output reg [31:0] rs1_data, rs2_data
    );

    reg [31:0]mem[0:31]; // 32x32 bit memory array
    integer i;

    always @(posedge clk or posedge rst)begin
        if (rst)begin
            for (i = 0; i < 32; i = i + 1)begin
                mem[i] <= 0;
            end
        end else begin
            if (rd_we == 1 && rd_addr != 0)begin
                mem[rd_addr] <= rd_wdata;
            end
        end
    end

    always @(*)begin
        rs1_data = (rs1_addr == 0)? 0 : mem[rs1_addr];
        rs2_data = (rs2_addr == 0)? 0 : mem[rs2_addr];
        mem[0] = 0;
    end
endmodule;

// Module Purpose: 
// Store instructions into 32x32 memory array
// This register file can store 1kb of data