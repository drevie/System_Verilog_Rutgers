module alu(input logic [31:0] a, b,
	input logic [2:0] f,
	output logic [31:0] y,
	output logic zero);

//encodings:
// ADD2
// SUB 6
// SLT 7
// AND1
// OR 3

always @(a,b,f)
begin
	case(f)
		3'h1: begin y = a & b; zero = y==0?1:0; end
		3'h2: begin y = a + b; zero = y==0?1:0; end
		3'h3: begin y = a | b; zero = y==0?1:0; end
		3'h6: begin y = a - b; zero = y==0?1:0; end
		3'h7: begin y = a < b; zero = y==0?1:0; end
	endcase
end
endmodule

module testbench();
	logic clk;
	logic [31:0] a, b, y, y_expect;
	logic [2:0] f;
	logic zero,zero_exp;
	logic [3:0] fin,zero_in;
	logic [15:0] num_vec, errors;
	logic [103:0] testvectors[50:0];

// create device
alu my_ALU(a, b, f, y, zero);
// set clock
always
begin
	clk = 1; #10; clk = 0; #10;
end

// Load vector test file
initial
begin
	$readmemh("alu.tv", testvectors);
	num_vec = 0; errors = 0;
end

// use vectors on clock edge
always @(posedge clk)
begin
	#1; {fin, a, b, y_expect, zero_in} = testvectors[num_vec];
	f = fin[2:0];
	zero_exp = zero_in[0];
end

// get the result on falling edge
always @(negedge clk)
begin
	if (y !== y_expect) begin
		$display("ERROR inputs = %h", {a, b, f});
		$display(" outputs = %h (%h expected)",y, y_expect);
		errors = errors + 1;
	end

	num_vec = num_vec + 1;
	if (testvectors[num_vec] === 104'bx) begin
		$display("%d all tests finished with %d errors",
			num_vec, errors);
// $stop;
end
end
endmodule