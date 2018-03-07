// Ryan Pencak
// MUX.v

/* MUX_2_1_32bit module: 32 bit multiplexor function from 2 inputs to 1 output */
module MUX_2_1_32bit(input select, input [31:0] mux_in_0, input [31:0] mux_in_1, output reg [31:0] mux_out);

always @(*)
begin
  if (select == 0)
    mux_out = mux_in_0;
  else
    mux_out = mux_in_1;
end

endmodule

/* MUX_2_1_5bit module: 5 bit multiplexor function for register inputs */
module MUX_2_1_5bit(input select, input [4:0] mux_in_0, input [4:0] mux_in_1, output reg [4:0] mux_out);

always @(*)
begin
  if (select == 0)
    mux_out = mux_in_0;
  else
    mux_out = mux_in_1;
end

endmodule
