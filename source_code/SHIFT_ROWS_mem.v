module SHIFT_ROWS_mem (clk,rst,addr,in,wr,out);
input clk,rst,wr;
input [3:0] addr;
input [7:0] in;
output reg [7:0] out;

reg [7:0] ram[0:15];
integer i;
always @ (posedge clk or negedge rst)
	begin	
	 if (!rst)
		begin
			out<=0;
			for (i=0;i<=15;i=i+1)
				ram[i]<=0;
		end	
	else
		begin
		if(wr)
			ram[addr]<=in;
		else 
			out<=ram[addr];
		end	
	end

endmodule
