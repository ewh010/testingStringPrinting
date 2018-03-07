// Ryan Pencak
// Sign_Extend_16_32.v

/* Sign_Extend_16_32 module: extends register from 16 to 32 bits*/
module Sign_Extend_16_32(input [31:0] instr, output reg [31:0] out_value);

  always @(*)
  begin

    if(instr[`op] == `ORI) // if opcode corresponds to an ORI instruction, pad with 0's instead of sign extending
      out_value = {16'b0, instr[15:0]};

    else // else sign extend
      out_value = {{16{instr[15]}}, instr[15:0]};

  end

endmodule
