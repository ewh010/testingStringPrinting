// IF_ID.v

/* module IF_ID: handles the pipelining from IF to ID stages */
module IF_ID(input clk, input PCSrcD, input [31:0] PC_Plus4_F, input [31:0] Instr_F, output reg [31:0] PC_Plus4_D, output reg [31:0] Instr_D);

  /* initialize outputs to zero */
  initial begin
    Instr_D = 0;
    PC_Plus4_D = 0;
  end

  /* at positive clock edge handle pipe from IF to ID */
  always @(posedge clock)
  begin
    if(PCSrcD)
    begin
      Instr_D = Instr_F;
      PC_Plus4_D = PC_Plus4_F;
    end
  end

endmodule
