Ryan Pencak
CSCI 320
Project 1



DESIGN:

  The design of this project directly follows the single cycle MIPS diagram given to us in Project 1.
  Each type of module in the diagram has a corresponding file and module(s) in the project folder.

  Similarly, each wire in the diagram has a wire in the testbench file, singleCycleMIPS.v.
  These wires connect the modules as they are declared in the test file.

  In essence, this project keeps track of the current PC by initializing it and setting it to either a Jump/Branch address or to register ra for a JR command.
  The program then reads in a memory file with a series of instructions which are then taken from instruction memory (memory.v).
  The instruction goes into a control module which determines all control signals based on the opcode and function.
  The registers module reads registers, where the write register and write data are determined by 2 to 1 mux modules.
  The data read from registers go into the ALU which handles calculations and setting another control signal, zero.
  Finally, the data memory handles read write and read memory and a final mux determines if the write data is the ALU result or read data.



COMPILATION:

  Add_Test:
    In memory.v, uncomment the $readmemh command for add_test.v and comment out the command for fibonacciRefined.v.
    Run in terminal:
      iverilog -o addtestOutput singleCycleMIPS.v

  Fibonacci:
    In memory.v, uncomment the $readmemh command for fibonacciRefined.v and comment out the command for add_test.v.
    Run in terminal:
      iverilog -o fibOutput singleCycleMIPS.v



EXECUTION:

  Run Add_Test:
    ./addtestOutput

  Run Fibonacci:
    ./fibOutput

  Execution will report the current and next PC as well as the instruction.

  I have documented the execution output for each test, add_test and fibonacci, in their respective folders:

    ./fibonacci/fib_output.txt has fibonacci execution output including all instruction types as well as control signals and outputs.

    ./add_test/addtest_output.txt has add_test execution output including all instruction types as well as control signals and outputs.



TESTING:

  My testing for both add_test and fibonacci relied on display statements throughout the code as well as using GTK Wave to view the contents of each register.

  For a full view of my output with testing display statements, please take a look at output text files described above.

  I also took screen shots of GTK Wave outputs for all of add_test and a portion of fibonacci which can be found in each folder:

    ./add_test/GTKWave_AddTest.png
    ./fibonacci/GTKWave_Fibonacci.png

  In order to confirm the function of both add_test and fibonacci, I used both my display statements and GTK Wave to monitor the contents of each register.
  Once I received the desired output, I was able to go through my output to see each instruction code and instruction type as well as each control signal.
  Following the MIPS code, I checked each instruction and made sure the correct thing was being loaded in the correct register.
  I tracked this through the entirety of the MIPS code until a loop was hit to confirm that the correct output was received for the correct reason.

  For example, the add_test execution was very simple to follow. I made sure what was stored in each register was 1 and 2 and also loaded 1 into v0 for syscall.
  I then saw the syscall execute to print the ALU result, 1+2 = 3.
