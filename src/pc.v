// Ryan Pencak
// pc.v

/* pc module: sets the output to the input on a clock */
module pc(input clk, input [31:0] nextPC, output reg [31:0] currPC);

initial
begin
    currPC = 32'h00400020;
end

always @(posedge clk)
begin
    if($time != 0) // don't run if time is 0
    begin
      currPC = nextPC;
    end
end

endmodule
