// Ryan Pencak
// alu.v

/* alu module: handles input from registers and output to data memory */
module ALU(reg1, reg2, ALUop,
          ALUresult);

  /* declare inputs */
  input [31:0] reg1;
  input [31:0] reg2;
  input [4:0] ALUop;

  /* declare outputs */
  output reg [31:0] ALUresult;

  /* declare lo and hi registers */
  reg [31:0] lo;
  reg [31:0] hi;

  initial begin
    lo = 32'b0;
    hi = 32'b0;
  end

  always @(*)
  begin

    // $display($time, " ALU given op = %3b, reg1 = %d, reg2 = %d", ALUop, reg1, reg2);

    case(ALUop)
      5'b00000: //AND
        ALUresult = reg1 & reg2;
      5'b00001: //OR
        ALUresult = reg1 | reg2;
      5'b00010: //ADD
        ALUresult = reg1 + reg2;
      5'b00011: //LUI
        ALUresult = {reg2, 16'b0};
      5'b00100: // MFLO
        ALUresult = lo;
      5'b00101: // MFHI
        ALUresult = hi;
      5'b00110: //SUB
        ALUresult = reg1 - reg2;
      5'b00111: //SLT
        begin
          if(reg1 < reg2)
            ALUresult = 1;
          else
            ALUresult = 0;
        end
      5'b01000: //SLL
        ALUresult = reg1 << reg2;
      5'b01001: //SRA
        ALUresult = reg1 >> reg2;
      5'b01010: // DIV
        begin
          lo = reg1 / reg2;
          hi = reg1 % reg2;
        end
      5'b01101: // MOVZ
        begin
          if(reg2 == 32'b0)
            ALUresult = reg1;
        end
    endcase

  end

endmodule
