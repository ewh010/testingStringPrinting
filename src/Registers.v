// Ryan Pencak
// Registers.v

/* Registers module: reads registers and outputs read data */
module Registers(input clk, input jal_control, input[31:0] jal_address, input [4:0] readReg1, input [4:0] readReg2, input [4:0] writeReg, input [31:0] writeData, input RegWrite, output reg [31:0] readData1, output reg [31:0] readData2, output wire [31:0] v0, output wire [31:0] a0, output wire [31:0] ra);

  reg [31:0] registers[0:31];
  integer i;

  /* initialize registers to 0 */
  initial begin
    for(i=0; i<32; i = i+1)
      registers[i] = 32'b0;
  end

  /* assign registers used in syscalls and JR/JAL for output */
  assign v0 = registers[`v0];
  assign a0 = registers[`a0];
  assign ra = registers[`ra];

  /* set register outputs*/
  always @(readReg1, readReg2)
  begin
    readData1 = registers[readReg1];
    readData2 = registers[readReg2];
  end

  /* write on negative edge of clock */
  always @(negedge clk)
  begin

    if ((RegWrite == 1) & (writeReg != `zero)) // write on control signal
    begin
      if (jal_control == 1) // write to register ra on control signal
        begin
          registers[`ra] = jal_address;
        end

      else // write data to writeReg
        begin
          registers[writeReg] = writeData;
        end
    end

  end

endmodule
