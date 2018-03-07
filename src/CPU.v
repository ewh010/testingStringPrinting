// Ryan Pencak
// testbench.v

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
`include "And.v"
`include "Data_Memory.v"
`include "Stats.v"


/* testbench module */
module testbench;

    /* declare 32 bit wires */
    wire [31:0] nextPC;
    wire [31:0] currPC;
    wire [31:0] instr;
    wire [31:0] PCplus4;
    wire [31:0] jumpAddr;
    wire [10:0] controlSignals;
    wire [31:0] writeData;
    wire [31:0] readData1;
    wire [31:0] readData2;
    wire [31:0] signExtendedValue;
    wire [31:0] aluResult;
    wire [31:0] aluMuxOut;
    wire [31:0] v0;
    wire [31:0] a0;
    wire [31:0] ra;
    wire [31:0] readData_mem;
    wire [31:0] branchAdderOut;
    wire [31:0] branch_mux_out;
    wire [31:0] jrMux_out;

    /* declare 5 bit write register */
    wire [4:0] writeReg;

    /* declare control signals */
    wire syscall_control;
    wire jal_control;
    wire jr_control;
    wire zero;
    wire and_out;
    reg clk;

    /* declare statistics wires */
    wire [31:0] number_instructions;
    wire stat_control;

    /* get current pc */
    pc PC_block(clk, nextPC, currPC);

    /* add 4 to pc for next pc */
    add4 PCadd4(currPC, PCplus4);

    /* get instruction from memory */
    memory instructionMemory(currPC, instr, number_instructions);

    /* calculate jump address */
    getJumpAddr JumpAddr_block(instr, PCplus4, jumpAddr);

    /* get all control signals from instruction */
    control control_block(instr, syscall_control, jr_control, jal_control, controlSignals);

    /* mux for write register input */
    mux_5bit registerMux(controlSignals[`REGDST], instr[20:16], instr[15:11], writeReg);

    /* execute registers block for read data outputs */
    registers reg_block(clk, jal_control, currPC+8, instr[25:21], instr[20:16], writeReg, writeData, controlSignals[`REGWRITE], readData1, readData2, v0, a0, ra);

    /* execute syscall if control signal is set based on v0 and a0 */
    syscall testSyscall(syscall_control, v0, a0, stat_control);

    /* sign extend the immediate value */
    signExtend_16_32 signExtend_block(instr, signExtendedValue);

    /* adder for branch address */
    adder branchAdder(PCplus4, signExtendedValue, branchAdderOut);

    /* mux for alu input 2 */
    mux_2_1 aluMux(controlSignals[`ALUSRC], readData2, signExtendedValue, aluMuxOut);

    /* execute alu block and output result and zero control signal */
    alu ALU_block(readData1, aluMuxOut, controlSignals[`ALUOP], aluResult, zero);

    /* and gate for branch mux control */
    andGate and_gate(controlSignals[`BRANCH], zero, and_out);

    /* mux for branch control */
    mux_2_1 branchMux(and_out, PCplus4, branchAdderOut, branch_mux_out);

    /* mux for jump control */
    mux_2_1 jumpMux(controlSignals[`JUMP], branch_mux_out, jrMux_out, nextPC);

    /* execute data memory for read/write */
    dataMemory dataMem(clk, controlSignals[`MEMWRITE], controlSignals[`MEMREAD], aluResult, readData2, readData_mem);

    /* mux to control input to writeData */
    mux_2_1 memToRegMux(controlSignals[`MEMTOREG], aluResult, readData_mem, writeData);

    /* mux for JR control */
    mux_2_1 jrMux(jr_control, jumpAddr, ra, jrMux_out);

    /* stats module for printing end of run statistics */
    stats runStats(clk, stat_control, number_instructions);


    always begin
      if(stat_control == 0)
      begin
        #10 clk = ~clk;
      end
    end

    initial
    begin

        clk = 1;

        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);

        // $monitor($time, " in %m, currPC = %08x, nextPC = %08x, instruction = %08x\n", currPC, nextPC, instr);

        #50000 $finish;

    end

endmodule
