module lab4_djr(input logic reset, clk, left, right, output logic la, lb, lc, ra, rb, rc);

// Define logic
logic[6:0] state, next_state;

// Define State Encodings
parameter s0 = 7'b0000001;
parameter s1 = 7'b0000010;
parameter s2 = 7'b0000100;
parameter s3 = 7'b0001000;
parameter s4 = 7'b0010000;


parameter s5 = 7'b0100000;
parameter s6 = 7'b1000000;

// Define next_state
always_ff @(posedge clk)
if(~reset)
begin state <= next_state; end
else begin state <= s0; end
always_comb

case(state)
s0: begin if (left && ~right) next_state = s1;
else if (right && ~left) next_state = s4;
else next_state = s0; end
s1: next_state = s2;
s2: next_state = s3;
s3: next_state = s0;
s4: next_state = s5;
s5: next_state = s6;
s6: next_state = s0;

endcase

assign la = (state == s1) | (state == s2) | (state == s3);
assign lb = (state == s2) | (state == s3);
assign lc = (state == s3);
assign ra = (state == s4) | (state == s5) | (state == s6);
assign rb = (state == s5) | (state == s6);
assign rc = (state == s6);

endmodule