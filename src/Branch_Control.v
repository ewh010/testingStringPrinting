// Ryan Pencak
// Branch_Control.v

/* MUX_2_1_32bit module: 32 bit multiplexor function from 2 inputs to 1 output */
module Branch_Control(input [2:0] BranchOp, input [31:0] input1, input [31:0] input2, output reg equalD);

  initial begin
    equalD = 0;
  end

  always @(*)
  begin

    equalD = 0;

    case(BranchOp)
      3'b001: // BEQ
        begin
        // $display("BEQ");
          if (input1 == input2)
            equalD = 1;
          else
            equalD = 0;
        end
      3'b100: // BNE
        begin
        // $display("BNE");
          if (input1 != input2)
            equalD = 1;
          else
            equalD = 0;
        end
      3'b110: // BLTZ
        begin
        // $display("BLTZ");
          if (input1 < 32'b0)
            equalD = 1;
          else
            equalD = 0;
        end
      default:
        begin
          equalD = 0;
        end
      endcase
  end

endmodule

// 3'b010: // BEQZ
//   begin
//   $display("BEQZ");
//     equalD = 0; // not yet handled
//   end
// 3'b011: // BLEZ
//   begin
//   $display("BLEZ");
//     equalD = 0; // not yet handled
//   end

// 3'b101: // BNEZ
//   begin
//   $display("BNEZ");
//     if (input1 != 32'b0)
//       equalD = 1;
//     else
//       equalD = 0;
//   end
