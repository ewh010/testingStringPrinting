// Ryan Pencak
// and.v

/* andGate module: simple and gate with two inputs */
module And_Gate(branch, zero, and_out);

  // inputs and outputs
  input branch;
  input zero;
  output reg and_out;

  always @(*)
  begin

    and_out = 0; // set and_out, which controls the branch mux, to 0

    if((branch == 1) & (zero == 1))
      and_out = 1; // set mux to choose branch address if branch and zero are 1
  end

endmodule
