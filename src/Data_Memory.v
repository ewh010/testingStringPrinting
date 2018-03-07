// Ryan Pencak
// dataMemory.v

/* dataMemory module: handles write and read data*/
module Data_Memory(input clk, input memWrite, input memRead, input [31:0] address, input [31:0] writeData, output reg [31:0] readData);

reg [31:0] memory[32'h7ffffffc>>2: (32'h7ffffffc>>2)-256]; // define memory from stack pointer shift right 2 to 256 less than that to make room

always @(*)
begin
  if (memRead == 1)
    readData = memory[address >> 2]; // at read, set readData to memory at address shifted right 2
end

always @(negedge clk)
begin
  if(memWrite == 1)
    memory[address >> 2] = writeData; // at write, set memory at address shifted right 2 to writeData
end

endmodule