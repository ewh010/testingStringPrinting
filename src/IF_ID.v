// IF_ID.v

/* module IF_ID: handles the pipelining from IF to ID stages */
module IF_ID(input clk, input PCSrcD, input [31:0] PC_F, input [31:0] Instr_F, input [31:0] PC_Plus4_F, output reg [31:0] PC_D, output reg [31:0] Instr_D, output reg [31:0] PC_Plus4_D);

  /* initialize outputs to zero */
  initial begin
    Instr_D = 0;
    PC_Plus4_D = 0;
    PC_D = 0;
  end

  /* at positive clock edge handle pipe from IF to ID */
  always @(posedge clk)
  begin
    if(PCSrcD)
    begin
      PC_D = PC_F;
      Instr_D = Instr_F;
      PC_Plus4_D = PC_Plus4_F;
    end
  end

endmodule
