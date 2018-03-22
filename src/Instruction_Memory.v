// Ryan Pencak
// memory.v

/* memory module: determines output data*/
module Instruction_Memory(currPC, instr,
                          number_instructions);

  /* declare inputs */
  input [31:0] currPC, instr;

  /* declare outputs */
  output reg [31:0] number_instructions;

  /* declare registers */
  reg [31:0] mem[29'h00100000:29'h00100100];

  initial begin
    // $readmemh(`TEST_FILE, mem);
    // $readmemh("../test/fibonacci/fibonacciRefined.v", mem);
    $readmemh("../test/add_test/add_test.v", mem);
    number_instructions = 0; // initial statistic
  end

  always @(currPC) begin
      instr = mem[currPC[31:2]];
      number_instructions = number_instructions + 1;
  end

endmodule
