// Ryan Pencak
// control.v

`include "../include/mips.h"

/* control module: determines control signal values */
module Control(input [31:0] instr, output reg syscall_control, output reg jr_control, output reg jal_control, output reg [10:0] controlSignals);

  /* declare control signals */
  reg RegDst;
  reg Jump;
  reg Branch;
  reg MemRead;
  reg MemToReg;
  reg [2:0] ALUop;
  reg RegWrite;
  reg ALUsrc;
  reg MemWrite;

  always @(instr) // case on instruction
  begin

    /* initialize control signals to 0 */
    RegDst = 0;
    Jump = 0;
    Branch = 0;
    MemRead = 0;
    MemToReg = 0;
    ALUop = 3'b000;
    RegWrite = 0;
    ALUsrc = 0;
    MemWrite = 0;
    syscall_control = 0;
    jr_control = 0;
    jal_control = 0;

    case (instr[`op]) // case on opcode

      `LUI: // Load Upper Immediate
        begin
          RegWrite = 1;
          ALUsrc = 1;
          ALUop = 3'b011;
        end

      `J: // Jump
          Jump = 1;

      `JAL: // Jump and Link
        begin
          Jump = 1;
          RegWrite = 1;
          jal_control = 1;
        end

      `ADDI , `ADDIU: // ADD Immediate
        begin
          RegWrite = 1;
          ALUop = 3'b010;
          ALUsrc = 1;
        end

      `ORI: // OR Immediate
        begin
          RegWrite = 1;
          ALUop = 3'b001;
          ALUsrc = 1;
        end

      `BEQ , `BNE: // Branch on Equal and Not Equal
        begin
          Branch = 1;
          ALUop = 3'b110;
        end

      `LW: // Load Word
        begin
          MemRead = 1;
          MemToReg = 1;
          RegWrite = 1;
          ALUsrc = 1;
          ALUop = 3'b010;
        end

      `SW: // Store Word
        begin
          ALUop = 3'b010;
          ALUsrc = 1;
          MemWrite = 1;
        end

      `SPECIAL: // R-type Instruction
        begin
          RegDst=1;
          RegWrite = 1;

          case (instr[`function])

            `ADD:
              ALUop = 3'b010;

            `SUB:
              ALUop = 3'b110;

            `AND:
              ALUop = 3'b000;

            `OR:
              ALUop = 3'b001;

            `SLT:
              ALUop = 3'b111;

            `JR:
            begin
              Jump = 1; RegWrite = 1;
              jr_control = 1;
            end

            `SYSCALL:
            begin
              syscall_control = 1;
              RegWrite = 1;
            end

            6'b000000: //NOP
              ALUop = 3'bxxx;

            default:
              $display("R Instruction Not Listed\n");

          endcase
        end

      default:
        $display("Instruction Not Found\n");

    endcase

    controlSignals = {RegDst, Jump, Branch, MemRead, MemToReg, ALUop, RegWrite, ALUsrc, MemWrite};
    // $display("ALUop = %03x\nRegDst = %01x | Jump = %01x | Branch = %01x | MemRead = %01x | MemToReg = %01x | RegWrite = %01x | ALUsrc = %01x | MemWrite = %01x\n", ALUop, RegDst, Jump, Branch, MemRead, MemToReg, RegWrite, ALUsrc, MemWrite);

  end //end always

endmodule
