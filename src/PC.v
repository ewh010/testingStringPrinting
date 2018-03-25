// Ryan Pencak
// PC.v

/* PC module: sets the output to the input on a clock */
module PC(clk, StallF, nextPC,
          currPC);

  /* declare inputs */
  input clk, StallF;
  input [31:0] nextPC;

  /* declare outputs */
  output reg [31:0] currPC;

  initial
  begin
      currPC = 32'h00400020;
  end

  always @(posedge clk)
  begin
      if(($time != 0) && (!StallF)) // don't run if time is 0 or stall
      begin
        currPC = nextPC;
      end
  end

endmodule
