//IF_ID.v

/* module MEM_WB: handles the pipelining from MEM to WB stages */
module MEM_WB (input clk, input RegWriteM, input MemtoRegM, input [31:0] Data_Mem_Out_M, input [31:0] ALU_Out_M, output reg RegWriteW, output reg MemtoRegW, output reg [31:0] Data_Mem_Out_W, output reg [31:0] Data_Mem_Out_W);

  /* initialize outputs to zero */
  initial begin
    RegWriteW = 0;
    MemtoRegW = 0;
    Data_Mem_Out_W = 0;
    ALU_Out_W = 0;
  end

  /* at positive clock edge handle pipe from IF to ID */
  always @(posedge clk)
  begin
    RegWriteW = RegWriteM;
    MemtoRegW = MemtoRegM;
    Data_Mem_Out_W = Data_Mem_Out_M;
    ALU_Out_W = ALU_Out_M;
  end

endmodule
