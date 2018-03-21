// Hazard_Unit.v

/* Hazard_Unit module: handles pipeline stalls and forwarding */
module Hazard_Unit(BranchD, MemReadE, MemtoRegE, RegWriteE, MemReadM, MemtoRegM, RegWriteM, RegWriteW, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE, RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW);

  // define inputs
  input BranchD;
  input [4:0] MemReadE, MemtoRegE, RegWriteE, MemReadM, MemtoRegM, RegWriteM, RegWriteW;

  // define outputs
  output reg StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE;
  output reg [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW;

  initial begin
    ForwardAD = 0;
    ForwardBD = 0;
    ForwardAE = 0;
    ForwardBE = 0;
  end

  always @(*) begin
    // Hazard Detection for ID Stage
    // if (MemReadE & ((RtE == RsD) | (RtE == RtD))) begin
    //
    // end

    // Stall: depend on result of previous R-type -- stall decode
    if (RegWriteE and !MemReadE and ((WriteRegE == RsD) or (WriteRegE == RtD))) begin
      // PCWrite = 0
      // IFIDWrite = 0
      // ControlSelect = 0
      StallF = 1;
    end

    // Stall: depend on operation of previous load word 1 cycle ago
    if (RegWriteE and MemReadE and ((RtE == RsD) or (RtE == RtD))) begin
      // PCWrite = 0
      // IFIDWrite = 0
      // ControlSelect = 0
      StallD = 1;
    end

    // Stall: depend on operation of load work 2 cycles ago
    if (RegWriteM and MemReadM and ((RtM == RsD) or (RtM == RtD))) begin
      PCWrite = 0
      IFIDWrite = 0
      ControlSelect = 0
      FlushE = 1;
    end

    // Forward
    if (RegWriteM and !MemReadM and WriteRegM != 0 and WriteRegM == RsD) begin
      ForwardAD = 1;
    end

    if (RegWriteM and !MemRead and WriteRegM == RtD) begin
      ForwardBD = 1;
    end

  end

endmodule
