// Main File

/* include external module files */
`include "../include/mips.h"
`include "PC.v"
`include "Adder.v"
`include "Instruction_Memory.v"
`include "Get_Jump_Addr.v"
`include "Control.v"
`include "MUX.v"
`include "Syscall.v"
`include "ALU.v"
`include "Registers.v"
`include "Sign_Extend_16_32.v"
`include "And_Gate.v"
`include "Data_Memory.v"
`include "Stats.v"
`include "IF_ID.v"
`include "ID_EX.v"
`include "EX_MEM.v"
`include "MEM_WB.v"


/* testbench module */
module testbench;

    /* declare clock */
      reg clk;

    /* temp control signals */
      wire zero;

    /* declare statistics wires */
      wire [31:0] number_instructions;
      wire stat_control;

    /* declare IF Stage wires */
      wire PCSrc_D = 0;
      wire [31:0] PCPlus4_F;
      wire [31:0] PCBranch_D;
      wire [31:0] Next_PC;
      wire [31:0] PC_F;
      wire [31:0] instr_F;

    /* declare ID Stage wires */
      wire [31:0] instr_D;
      wire [31:0] PCPlus4_D;
      wire [31:0] PC_D;
      wire [31:0] signImm_D;
      wire [31:0] RD1_D;
      wire [31:0] RD2_D;

      // registers
      wire [31:0] v0;
      wire [31:0] a0;
      wire [31:0] ra;

      // pipeline signals
      wire [4:0] EX_D;
      wire [1:0] MEM_D;
      wire [1:0] WB_D;

      // control signals
      wire jump;
      wire branch;
      wire syscall_control;
      wire jal_control;
      wire jr_control;

    /* declare EX Stage wires */
      wire [4:0] Rs_E;
      wire [4:0] Rt_E;
      wire [4:0] Rd_E;
      wire [31:0] RD1_E;
      wire [31:0] RD2_E;
      wire [31:0] signImm_E;

      wire [4:0] writeReg_E;
      wire [31:0] srcB;
      wire [31:0] ALUOut_E;

      // pipeline signals
      wire [4:0] EX_E;
      wire [1:0] MEM_E;
      wire [1:0] WB_E;

    /* declare MEM Stage wires */

      wire [31:0] ALUOut_M;
      wire [31:0] writeData_M;
      wire [4:0] writeReg_M;
      wire [31:0] readData_M;

      // pipeline signals
      wire [1:0] MEM_M;
      wire [1:0] WB_M;

    /* declare WB Stage wires */

      wire [4:0] writeReg_W;
      wire [31:0] readData_W;
      wire [31:0] ALUOut_W;
      wire [31:0] Result_W;

      // pipeline signals
      wire [1:0] WB_W;

    /* IF Stage */

      // mux for branch control
      Mux_2_1_32bit branchMux(PCSrc_D, PCPlus4_F, PCBranch_D, Next_PC);

      // get current pc
      PC PC_block(clk, Next_PC, PC_F);

      // get instruction from memory
      Instruction_Memory instructionMemory(PC_F, instr_F, number_instructions);

      // add 4 to pc for next pc
      Add4 PCadd4(PC_F, PCPlus4_F);


    /* Pipeline */

      // IF to ID Pipeline
      IF_ID IfId(clk, PCSrc_D, PC_F, instr_F, PCPlus4_F, PC_D, instr_D, PCPlus4_D);


    /* ID Stage */

      // get all control signals from instruction
      Control control_block(instr_D, EX_D, MEM_D, WB_D, jump, branch, syscall_control, jr_control, jal_control);

      // execute registers block for read data outputs
      Registers reg_block(clk, jal_control, PC_D+8 /*JAL*/, instr_D[25:21], instr_D[20:16], writeReg_W, Result_W, WB_D[`REGWRITE_W], RD1_D, RD2_D, v0, a0, ra);

      // sign extend the immediate value
      Sign_Extend_16_32 signExtend_block(instr_D, signImm_D);

      // adder for branch address
      Adder branchAdder(PCPlus4_D, signImm_D, PCBranch_D);

      // and gate for branch mux control
      And_Gate branch_control(branch, zero, PCSrc_D);

      // calculate jump address
      // Get_Jump_Addr JumpAddr_block(instrD, PCPlus4D, jumpAddr);

      // mux for jump control ??
      // Mux_2_1_32bit jumpMux(jump, Next_PC, jrMux_out, branch_mux_out);

      // mux for JR control
      // Mux_2_1_32bit jrMux(jr_control, jumpAddr, ra, jrMux_out);

      // execute syscall if control signal is set based on v0 and a0
      Syscall testSyscall(syscall_control, v0, a0, stat_control);


    /* Pipeline */

      // ID to EX Pipeline
      ID_EX IdEx(clk, EX_D, MEM_D, WB_D, instr_D[25:21], instr_D[20:16], instr_D[15:11], RD1_D, RD2_D, signImm_D, EX_E, MEM_E, WB_E, Rs_E, Rt_E, Rd_E, RD1_E, RD2_E, signImm_E);


    /* EX Stage */

      // mux for write register input
      Mux_2_1_5bit registerMux(EX_E[`REGDST_E], Rt_E, Rd_E, writeReg_E);

      // mux for alu input 2
      Mux_2_1_32bit aluMux(EX_E[`ALUSRC_E], RD2_E, signImm_E, srcB);

      // execute alu block and output result and zero control signal
      ALU ALU_block(RD1_E, srcB, EX_E[`ALUOP_E], ALUOut_E, zero);


    /* Pipeline */

      // EX to MEM Pipeline
      EX_MEM ExMem(clk, MEM_E, WB_E, ALUOut_E, RD2_E, writeReg_E, MEM_M, WB_M, ALUOut_M, writeData_M, writeReg_M);


    /* MEM Stage */

      // execute data memory for read/write
      Data_Memory dataMem(clk, MEM_M[`MEMWRITE_M], MEM_M[`MEMREAD_M], ALUOut_M, writeData_M, readData_M);


    /* Pipeline */

      // MEM to WB Pipeline
      MEM_WB MemWb(clk, WB_M, readData_M, ALUOut_M, writeReg_M, WB_W, readData_W, ALUOut_W, writeReg_W);


    /* WB Stage */

      // mux to control input to ResultW
      Mux_2_1_32bit memToRegMux(WB_W[`MEMTOREG_W], ALUOut_W, readData_W, Result_W);


    /* Statistics */

      // stats module for printing end of run statistics
      Stats runStats(clk, stat_control, number_instructions);


    always begin
      if(stat_control == 0)
      begin
        #10 clk = ~clk;
      end
    end

    initial begin

      clk = 1;

      $dumpfile("testbench.vcd");
      $dumpvars(0,testbench);

      $monitor($time, " in %m, currPC = %08x, nextPC = %08x, instruction = %08x, ALUOut_E = %08x, ALUOut_M = %08x, ALUOut_W = %08x, readData_M = %08x, readData_W = %08x\n", PC_F, Next_PC, instr_F, ALUOut_E, ALUOut_M, ALUOut_W, readData_M, readData_W);

      #880 $finish;

    end

endmodule
