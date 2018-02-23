// Ryan Pencak
// stats.v

/* stats module: prints statistics for run */
module stats(input clk, input stat_control, input [31:0] number_instructions);

  reg [31:0] number_cycles;

  initial begin
    number_cycles = 0;
  end

  always @(posedge clk)
  begin
    number_cycles = number_cycles + 1;
  end

  always @(stat_control)
  begin
    if(stat_control == 1)
    begin
      $display("End of Run Statistics:\n");
      $display($time, " Total Time Units | Number of Cycles: %0d | Number of Instructions: %0d | IPC: %0d", number_cycles, number_instructions, (number_instructions/number_cycles));
    end
  end

endmodule
