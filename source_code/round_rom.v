module round_rom #(parameter FILENAME="rom.init.txt")(clk,addr,out);
input wire clk;
input wire [3:0] addr;
output reg [7:0] out;

reg [7:0] rom [0:15];
initial 
	begin
		$readmemh(FILENAME,rom);
	end		
	
always @(posedge clk)
begin  
	out<=rom[addr];
end

//assign 	out=out_reg;

endmodule
