// Ryan Pencak
// adder.v

/* add4 module: adds 4 to input address */
module Add4(currPC, PCplus4);

  // inputs and outputs
  input [31:0] currPC;
  output [31:0] PCplus4;

  assign PCplus4 = currPC + 4;

endmodule

/* adder module: adds a signExtendedImmediate shifted left 2 to PC_Plus4 for Jump commands*/
module Adder(PC_Plus4,signExtendedImmediate, out);

  // inputs and outputs
  input [31:0] PC_Plus4;
  input [31:0] signExtendedImmediate;
  output reg [31:0] out;

  always @(*)
  begin
    out = PC_Plus4 + {signExtendedImmediate << 2};
  end

endmodule
