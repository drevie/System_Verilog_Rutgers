module lab8_djr(input [70:0]SW, input KEY[0], output [63:0]LEDR);
parameter length = 64; 		   // Length of input
logic [length-1:0]data;
always@(posedge KEY[0]) begin
	if(SW[70] == 1)
	begin
		data = SW[63:0];
	end

	if(SW[64] == 1)
	begin
		data = {data[0:0], data[length-1:1]}; 
	end
	if(SW[65] == 1)
	begin
		data = {data[1:0], data[length-1:2]}; 
	end
	if(SW[66] == 1)
	begin
		data = {data[3:0], data[length-1:4]}; 
	end
	if(SW[67] == 1)
	begin
		data = {data[7:0], data[length-1:8]}; 
	end
	if(SW[68] == 1)
	begin
		data = {data[15:0], data[length-1:16]}; 
	end
	if(SW[69] == 1)
	begin
		data = {data[31:0], data[length-1:32]}; 
	end
end

always
begin
	LEDR = data[7:0]; 	// Assign shifted data to LEDR
end
endmodule // lab9_djr
