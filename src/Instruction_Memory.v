// Ryan Pencak
// memory.v

/* memory module: determines output data*/
module memory(input [31:0] currPC, output reg [31:0] instr, output reg [31:0] number_instructions);

    reg [31:0] mem[29'h00100000:29'h00100100];

    initial begin
      // $readmemh(`TEST_FILE, mem);
      $readmemh("../test/add_test/add_test.v", mem);

      number_instructions = 0; // initial statistic
    end

    always @(currPC) begin
        instr = mem[currPC[31:2]];
        number_instructions = number_instructions + 1;
    end

endmodule
