// IF_ID.v

/* module IF_ID: handles the pipelining from IF to ID stages */
module IF_ID(clk, StallD, PCSrcD, PC_F, Instr_F, PC_Plus4_F,
            PC_D, Instr_D, PC_Plus4_D);

  /* declare inputs */
    input clk, StallD, PCSrcD;
    input [31:0] PC_F, Instr_F, PC_Plus4_F;

  /* declare outputs */
    output reg [31:0] PC_D, Instr_D, PC_Plus4_D;

  /* initialize outputs to zero */
  initial begin
    Instr_D = 0;
    PC_Plus4_D = 0;
    PC_D = 0;
  end

  /* at positive clock edge handle pipe from IF to ID */
  always @(posedge clk)
  begin
    if(StallD) begin
      Instr_D = Instr_D;
      PC_Plus4_D = PC_Plus4_D;
      PC_D = PC_D;
    end
    else if(!PCSrcD) begin
      PC_D = PC_F;
      Instr_D = Instr_F;
      PC_Plus4_D = PC_Plus4_F;
    end
  end

endmodule
