module SHIFT_ROWS_state(clk,rst,start,data_in,count,out,done,
						MIX_COL_start,MIX_COL_addr,ADD_ROUND_start,ADD_ROUND_addr);
						
input wire clk,rst,start,MIX_COL_start,ADD_ROUND_start;
input wire [7:0] data_in;
input wire [3:0] count,MIX_COL_addr,ADD_ROUND_addr;
output wire [7:0] out;
output wire done;

reg [3:0] SHIFT_ROWS_addr;

reg [3:0] rom [0:15];
initial 
	begin
		$readmemh("SHIFT_ROWS_mem.txt",rom);
	end
	
always @(*)
	begin
		if (start)
			SHIFT_ROWS_addr<=rom[count];
		else if(MIX_COL_start)
			SHIFT_ROWS_addr<=MIX_COL_addr;
		else if(ADD_ROUND_start)
			SHIFT_ROWS_addr<=ADD_ROUND_addr;			
		else 	
			SHIFT_ROWS_addr<=0;
	end	
	
SHIFT_ROWS_mem SHIFT_ROWS_mem (clk,rst,SHIFT_ROWS_addr,data_in,start,out);
	
assign done = (count==15&&start);	
endmodule
