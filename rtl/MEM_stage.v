module MEM_stage(
    input
        mem_read,
        mem_write,
        clk,
    input [31:0]
        ALU_result,
        rs2_forward,
    output reg [31:0]
        mem_data
    );

    reg [31:0]data_mem[255:0]; // 1kb data memory
    wire [7:0]addr;

    assign addr = ALU_result[9:2]; // 0 and 1 skipped because 00 01 10 11 alwys get ignored, so next 8 bits are used for address

    always @(posedge clk)begin
        if (mem_write)begin
            data_mem[addr] <= rs2_forward;
        end
    end

    always @(*)begin
        if (mem_read)begin
            mem_data = data_mem[addr];
        end
        else begin
            mem_data = 32'b0;
        end
    end
endmodule;

// Module Purpose:
// Acts as an interface between EX stage andd Data memory for lw and sw (load word store word)