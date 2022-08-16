module comparator_FF(in,out);
input wire [8:0] in;
output reg [7:0] out;

always @(*)
	begin
		if (in > 8'hFF)
			out<=in-8'hFF;
		else 
			out<=in[7:0];	
	end
	
endmodule
