module WB_stage(
    input [31:0]ALU_result, mem_data,
    input mem_to_reg,
    output reg [31:0] rd_w_data
    );

    always @(*) begin
        if (mem_to_reg)begin
            rd_w_data = mem_data;
        end else begin
            rd_w_data = ALU_result;
        end
    end
endmodule;