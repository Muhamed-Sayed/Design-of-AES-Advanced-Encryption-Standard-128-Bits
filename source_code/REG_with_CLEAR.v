module REG_MIX_COL #(parameter size =8)(clk,rst,flag,clear,in,out);
input	wire 	[size-1:0] 	 in;
input	wire			 clk,rst,clear;
input wire flag;
output reg 	[size-1:0] 	 out;

 always @(posedge clk or negedge rst)
  begin
   if (!rst)
   	begin out<=0; end
   else if (clear&&flag==0)
		out<=0;
	else if (clear&&flag)
		out<=in;
	else	
		begin
			out<=in^out ;
		end
  end		

endmodule
