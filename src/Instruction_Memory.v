// Ryan Pencak
// memory.v

/* memory module: determines output data*/
module Instruction_Memory(currPC,
                          instr, number_instructions);

  /* declare inputs */
  input [31:0] currPC;

  /* declare outputs */
  output reg [31:0] instr, number_instructions;

  /* declare registers */
  reg [31:0] mem[29'h00100000:29'h00100100];

  initial begin
    /* UNCOMMENT THIS TO COMPILE ADD_TEST */
    // $readmemh("../test/add_test/add_test.v", mem);

    /* UNCOMMENT THIS TO COMPILE HELLO_WORLD */
    // $readmemh("../test/hello_world/hello.v", mem);

    /* UNCOMMENT THIS TO COMPILE FIBONACCI */
    $readmemh("../test/fibonacci/fib.v", mem);

    number_instructions = 0; // initial statistic
  end

  always @(currPC) begin
      instr = mem[currPC[31:2]];
      number_instructions = number_instructions + 1;
  end

endmodule

// $readmemh(`TEST_FILE, mem);
