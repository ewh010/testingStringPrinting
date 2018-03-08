// Ryan Pencak
// alu.v

/* alu module: handles input from registers and output to data memory */
module ALU(input [31:0] reg1, input [31:0] reg2, input [2:0] ALUop, output reg [31:0] ALUresult, output reg zero);

  always @(*)
  begin

    // $display($time, " ALU given op = %3b, reg1 = %d, reg2 = %d", ALUop, reg1, reg2);

    case(ALUop)
      3'b000: //AND
        ALUresult = reg1 & reg2;
      3'b001: //OR
        ALUresult = reg1 | reg2;
      3'b010: //ADD
        ALUresult = reg1 + reg2;
      3'b110: //SUB
        ALUresult = reg1 - reg2;
      3'b011: //LUI
        ALUresult = {reg2, 16'b0};
      3'b111: //SLT
      begin
        if(reg1 < reg2)
          ALUresult = 1;
        else
          ALUresult = 0;
      end
    endcase

    zero = (ALUresult == 0) ? 1:0; // set variable zero to 1 if ALU result is 0, else set to 0

  end

endmodule
