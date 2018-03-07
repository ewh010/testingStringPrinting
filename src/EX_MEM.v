// Ryan Pencak
// EX_MEM.v

/* EX to MEM module */
module EX_MEM(input clock, input [1:0] WB, input [2:0] MEMOut, input [4:0] regRD, input [31:0] ALUOut, input [31:0] WriteDataE, output reg [1:0] WBreg, output reg [2:0] MEMreg, outputreg  [31:0] ALUreg, output reg [31:0] WriteDataM, output reg  [4:0] RegRDreg)
	initial
	begin
		WDreg = 0;
		MEMreg = 0;
		ALUreg = 0;
		WriteDataM = 0;
		RegRDreg = 0;
	end

	always @(posedge clock)
	begin
		WBreg = WB;
		MEMreg = MEMOut;
		ALUreg = ALUOut;
		RegRDreg = regRD; 
	end
