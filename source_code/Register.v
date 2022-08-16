module Register #(parameter size =4)( clk,rst,D,Q);
input	wire 	[size-1:0] 	 D;
input	wire			 clk,rst;
output reg 	[size-1:0] 	 Q;
 always @(posedge clk or negedge rst)
  begin
   if (!rst)
   	Q<=0;
   else 
   	Q<=D;
  end		
endmodule

