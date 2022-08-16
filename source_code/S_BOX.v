module S_BOX(clk,addr,out);
input wire clk;
input wire [7:0] addr;
output reg [7:0] out;

reg [7:0] rom [0:255];
initial 
	begin
		$readmemh("S_BOX.txt",rom);
	end		
	
always @(posedge clk )
begin  
	out<=rom[addr];
end

//assign 	out=out_reg;

endmodule
