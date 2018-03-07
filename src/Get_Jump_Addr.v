// Ryan Pencak
// getJumpAddr.v

/* getJumpAddr module: calculates the jump address */
module Get_Jump_Addr(input [31:0] instr, input [31:0] PCplus4, output wire [31:0] jumpAddr);

    assign jumpAddr = {PCplus4[31:28], instr[25:0] << 2}; // Calculate jump address based on PC+4 and instruction

endmodule
