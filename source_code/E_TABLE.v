module E_TABLE(clk,addr,out);
input wire clk;
input wire [7:0] addr;
output reg [7:0] out;

reg [7:0] rom [0:255];
initial 
	begin
		$readmemh("E_TABLE.txt",rom);
	end		
	
always @(posedge clk )
begin  
	out<=rom[addr];
end

//assign 	out=out_reg;

endmodule
