// Hazard_Unit.v

/* Hazard_Unit module: handles pipeline stalls and forwarding */
module Hazard_Unit(sycall_control, BranchD, MemReadE, MemtoRegE, RegWriteE, MemReadM, MemtoRegM, RegWriteM, RegWriteW, RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW,
                  StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE, sysstall);

  // define inputs
  input sycall_control, BranchD, MemReadE, MemtoRegE, RegWriteE, MemReadM, MemtoRegM, RegWriteM, RegWriteW;
  input [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW;

  // define outputs
  output reg StallF, StallD, FlushE, ForwardAD, ForwardBD, sysstall;
  output reg [1:0] ForwardAE, ForwardBE;

  // define registers
  reg lwstall;
  reg branchstall;

  initial begin
    StallF = 0;
    StallD = 0;
    FlushE = 0;
    ForwardAD = 0;
    ForwardBD = 0;
    ForwardAE = 2'b0;
    ForwardBE = 2'b0;
    sysstall = 0;
  end

  always @(*) begin

    /* Stalling Logic */

      // load word stall
      lwstall = (((RsD == RtE) || (RtD == RtE)) && MemtoRegE);

      // branch stall
      branchstall = ((BranchD && RegWriteE && ((WriteRegE == RsD) || (WriteRegE == RtD))) || (BranchD && MemtoRegM && ((WriteRegM == RsD) || (WriteRegM == RtD))));

      sysstall = ((sycall_control && RegWriteE && ((WriteRegE == `v0) || (WriteRegE == `a0))) || (sycall_control && RegWriteM && ((WriteRegM == `v0) || (WriteRegM == `a0))) || (sycall_control && RegWriteW && ((WriteRegW == `v0) || (WriteRegW == `a0))));

      // set stall signals
      StallF = (lwstall || branchstall || sysstall);
      StallD = StallF;
      FlushE = StallF;


    /* Forwarding Logic*/

      // Set forward signals to Decode Stage
      ForwardAD = (RsD != 0) && (RsD == WriteRegM) && RegWriteM;
      ForwardBD = (RtD != 0) && (RtD == WriteRegM) && RegWriteM;

      // Set forward signals to Execute Stage for srcA
      if ((RsE != 0) && (RsE == WriteRegM) && (RegWriteM))
        ForwardAE = 2'b10;
      else if ((RsE != 0) && (RsE == WriteRegW) && RegWriteW)
        ForwardAE = 2'b01;
      else
        ForwardAE = 2'b00;

      // Set forward signals to Execute Stage for srcB
      if ((RtE != 0) && (RtE == WriteRegM) && RegWriteM)
        ForwardBE = 2'b10;
      else if ((RtE != 0) && (RtE == WriteRegW) && RegWriteW)
        ForwardBE = 2'b01;
      else
        ForwardBE = 2'b00;


    // $display("In Hazard-- BranchD=%1d, MemReadE=%1d, MemtoRegE=%1d, RegWriteE=%1d, MemReadM=%1d, MemtoRegM=%1d, RegWriteM=%1d, RegWriteW=%1d, RsD=%5d, RtD=%5d, RsE=%5d, RtE=%5d, WriteRegE=%5d, WriteRegM=%5d, WriteRegW=%5d, StallF=%1d, StallD=%1d, FlushE=%1d, lwstall=%1d, branchstall=%1d\n", BranchD, MemReadE, MemtoRegE, RegWriteE, MemReadM, MemtoRegM, RegWriteM, RegWriteW, RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW, StallF, StallD, FlushE, lwstall, branchstall);

  end

endmodule

    // Hazard Detection for ID Stage
    // if (MemReadE & ((RtE == RsD) | (RtE == RtD))) begin
    //
    // end

    // /* Stalling logic */
    //   // Stall: depend on result of previous R-type -- stall decode
    //   if (RegWriteE and !MemReadE and ((WriteRegE == RsD) or (WriteRegE == RtD))) begin
    //     // PCWrite = 0
    //     // IFIDWrite = 0
    //     // ControlSelect = 0
    //     StallF = 1;
    //   end
    //
    //   // Stall: depend on operation of previous load word 1 cycle ago
    //   if (RegWriteE and MemReadE and ((RtE == RsD) or (RtE == RtD))) begin
    //     // PCWrite = 0
    //     // IFIDWrite = 0
    //     // ControlSelect = 0
    //     StallD = 1;
    //   end
    //
    //   // Stall: depend on operation of load work 2 cycles ago
    //   if (RegWriteM and MemReadM and ((RtM == RsD) or (RtM == RtD))) begin
    //     // PCWrite = 0
    //     // IFIDWrite = 0
    //     // ControlSelect = 0
    //     FlushE = 1;
    //   end

    // // Set forward for Mem to Ex
    // if (RegWriteM and !MemReadM and WriteRegM != 0 and WriteRegM == RsD) begin
    //   ForwardAD = 1;
    // end
    // if (RegWriteM and !MemRead and WriteRegM == RtD) begin
    //   ForwardBD = 1;
    // end
    //
    // // Set forward for Mem to Mem
    // if (RegWriteM and !MemReadM and WriteRegM != 0 and WriteRegM == RsE) begin
    //   ForwardAE = 1;
    // end
    // if (RegWriteM and !MemRead and WriteRegM == RtE) begin
    //   ForwardBE = 1;
    // end
