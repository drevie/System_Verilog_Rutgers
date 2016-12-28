module lab07_djr(
input logic CLOCK_50,
input logic SW[0],
output logic [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
// Declare register large enough to hold count i.e. 32 bits
logic [31:0] clk_counter; 
// Declare initial adjusted clock 
logic delayed_clock; 
initial
begin
// set clk_counter and clock
clk_counter = 32'd00000; 
delayed_clock = 0; 
// Seven segment encodings 
// These encodings will be rotated through the algorithm
HEX0 = 7'b1000000;  // 0
HEX1 = 7'b1111001;  // 1
HEX2 = 7'b0100100;  // 2
HEX3 = 7'b0110000;  // 3
HEX4 = 7'b0011001;  // 4
HEX5 = 7'b0010010;  // 5
HEX6 = 7'b0000010;  // 6
HEX7 = 7'b1111000;  // 7
end
// adjusted value
always @(posedge CLOCK_50)
begin
if(clk_counter < 32'd25000000)
begin
clk_counter = clk_counter + 32'd1; 
end
else if(clk_counter >= 32'd25000000)
begin
delayed_clock = ~delayed_clock;
clk_counter = 32'd0; 
end
end
// At every positive edge of the delayed clock
always @(posedge delayed_clock)
begin
// Make sure pause is not enabled 
if(SW[0] == 0)
begin
// Rotate the position of the desired letter at each position 
HEX0 <= HEX7; 
HEX1 <= HEX0; 
HEX2 <= HEX1; 
HEX3 <= HEX2; 
HEX4 <= HEX3; 
HEX5 <= HEX4; 
HEX6 <= HEX5; 
HEX7 <= HEX6; 
end
end
endmodule