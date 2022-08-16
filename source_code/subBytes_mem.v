module subBytes_mem(clk,rst,W_En ,R_En,addr_in,addr_out,in,out);
input wire clk,rst ,W_En ,R_En;
input wire [3:0] addr_in,addr_out;
input wire [7:0] in;
output reg [7:0] out;

reg [7:0] ram [0:15];	
integer i;

always @(posedge clk or negedge rst)
	begin	
	if(!rst)
		begin
			out<=0;
			for (i=0;i<=15;i=i+1)
				ram[i]<=0;
		end	
	else
		begin
		if(W_En)
			ram[addr_in]<=in;
		if (R_En)  
			out<=ram[addr_out];
		end	
	end
endmodule
