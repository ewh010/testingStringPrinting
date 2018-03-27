// Ryan Pencak
// Registers.v

/* Registers module: reads registers and outputs read data */
module Registers(clk, jal_control, jal_address, readReg1, readReg2, writeReg, writeData, RegWrite,
                readData1, readData2, v0, a0, ra, sp);

  /* declare inputs */
  input clk, jal_control, RegWrite;
  input [31:0] jal_address, writeData;
  input [4:0] readReg1, readReg2, writeReg;

  /* declare outputs */
  output reg [31:0] readData1, readData2;
  output wire [31:0] v0, a0, ra, sp;

  /* declare registers and variables */
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
  assign sp = registers[`sp];

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
