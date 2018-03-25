// Ryan Pencak
// Equal.v

/* MUX_2_1_32bit module: 32 bit multiplexor function from 2 inputs to 1 output */
module Equal(input [31:0] input1, input [31:0] input2, output reg equalD);

always @(*)
begin
  if (input1 == input2)
    equalD = 1;
  else
    equalD = 0;
end

endmodule
