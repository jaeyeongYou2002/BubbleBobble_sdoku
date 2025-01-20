module clk_divider (
    input clk_in, 
    input rst, 
    output reg clk_out
);
reg[31:0] o=32'd0;
parameter DIVISOR = 32'd6000000;
//clk_out = clk_in / DIVISOR

always @(posedge clk_in, posedge rst) begin
   if (rst) clk_out <= 0; 
   else if(o == DIVISOR/2-1) begin
       o <= 0; 
       clk_out <= ~clk_out; 
   end 
   else o <= o + 1; 
end
endmodule


