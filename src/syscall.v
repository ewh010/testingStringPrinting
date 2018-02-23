// Ryan Pencak
// syscall.v

/* sycscall module: determine and execute syscall */
module syscall(input syscall_control, input [31:0] v0, input [31:0] a0, output reg stat_control);

  initial begin
    stat_control = 0;
  end

  always @(*)
  begin

    if(syscall_control == 1) // on syscall control signal
    begin
      // v0 as 1 indicates a print integer syscall
      if(v0 == 1)
        $display("\n\nSYCALL OUTPUT = %d\n\n", a0);

      // v0 as 10 indicates an execution kill
      else if(v0 == 10)
      begin
        $display("Syscall received 10, kill execution.\n\n");
        stat_control = 1;
        #1; $finish;
      end

    end
  end

endmodule
