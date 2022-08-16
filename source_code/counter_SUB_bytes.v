module counter_SUB_bytes(clk,rst,start,out,flag_sub,flag_shift);
input wire clk,rst,start;
output reg [3:0] out;

output reg flag_sub,flag_shift;

always @(posedge clk or negedge rst)
	begin
		if(!rst)
			begin out<=4'b0; flag_sub<=1'b0; flag_shift<=1'b0; end
			
		else if (out==15)
		   begin flag_sub<=1'b0; flag_shift<=!flag_shift;  out<=4'b0; end
			
		else if (start||flag_sub)
			begin
				out<=out+4'b1; flag_sub<=1'b1;
			end
			
		else if (flag_shift)	
			begin
				out<=out+4'b1; flag_shift<=1'b1;
			end
	end
endmodule
