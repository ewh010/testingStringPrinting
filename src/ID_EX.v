/*
Executes the operations passed from IDEX register
*/

module IDEX(input clk, input [3:0] EX, input [2:0] M, input [1:0] WB, input [4:0] RsD, input [4:0] RtD, input [4:0] RdD, input [31:0] RD1, input [31:0] DataB, input [31:0] SignImmD, output [1:0] WB_E, output [2:0] M_E, output [3:0] EX_E, output [4:0] RsE, output [4:0] RtE, output [4:0] RdE, output [31:0] RD1_E, output [31:0] DataB_E, output [31:0] SignImmE);


reg [1:0] WB_E 
reg [2:0] M_E 
reg [3:0] EX_E 
reg [4:0] RsE 
reg [4:0] RtE 
reg [4:0] RdE 
reg [31:0] RD1E 
reg [31:0] RD2E 
reg [31:0] SignImmE

initial begin
 		WB_E = 0;
 		M_E = 0;
 		EX_E = 0;
 		Rs_E = 0;
 		Rt_E = 0;
 		Rd_E = 0;
 		RD1 = 0;
 		RD2 = 0;
 		SignImmD = 0;

 end

 always(@clk)
 begin
 		WB_E <= WB;
 		M_E <= M;
 		EX_E <= EX;
 		Rs_E <= RsD;
 		Rt_E <= RtD;
 		Rd_E <= RdD;
 		RD1E <= RD1;
 		RD2E <= RD2;
 		SignImmE <= SignImmD;

 end
 endmodule