// Hazard_Unit.v

/* Hazard_Unit module: handles pipeline stalls and forwarding */
module Hazard_Unit(BranchD, MemReadE, MemtoRegE, RegWriteE, MemReadM, MemtoRegM, RegWriteM, RegWriteW, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE, RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW);

  // define inputs
  input BranchD;
  input [4:0] MemReadE, MemtoRegE, RegWriteE, MemReadM, MemtoRegM, RegWriteM, RegWriteW;

  // define outputs
  output reg StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE;
  output reg [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW;

  // define registers
  reg lwstall;
  reg branchstall;

  initial begin
    StallF = 0;
    StallD = 0;
    FlushE = 0;
    ForwardAD = 0;
    ForwardBD = 0;
    ForwardAE = 0;
    ForwardBE = 0;
  end

  always @(*) begin

    /* Stalling Logic */

    // load word stall
    lwstall = ((rsD == rtE) or (rtD == rtE)) and MemtoRegE;

    // branch stall
    branchstall = ((BranchD and RegWriteE and ((WriteRegE == rsD) or (WriteRegE == rtD))) or (BranchD and MemtoRegM and ((WriteRegM == rsD) or (WriteRegM == rtD))));

    // set stall signals
    StallF = StallD = FlushE = (lwstall or branchstall);


    /* Forwarding Logic*/

    // Set forward signals to Decode Stage
    ForwardAD = (rsD != 0) and (rsD == WriteRegM) and RegWriteM;
    ForwardBD = (rtD != 0) and (rtD == WriteRegM) and RegWriteM;

    // Set forward signals to Execute Stage for srcA
    if ((rsE != 0) and (rsE == WriteRegM) and RegWriteM)
      ForwardAE = 10;
    else if ((rsE != 0) and (rsE == WriteRegW) and RegWriteW)
      ForwardAE = 01;
    else
      ForwardAE = 00;

    // Set forward signals to Execute Stage for srcB
    if ((rtE != 0) and (rtE == WriteRegM) and RegWriteM)
      ForwardBE = 10;
    else if ((rtE != 0) and (rtE == WriteRegW) and RegWriteW)
      ForwardBE = 01;
    else
      ForwardBE = 00;

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
