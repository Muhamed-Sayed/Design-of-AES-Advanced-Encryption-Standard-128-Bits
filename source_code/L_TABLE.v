module L_TABLE(addr1,addr2,out1,out2);
input wire [7:0] addr1,addr2;
output reg [7:0] out1,out2;

reg [7:0] rom [0:255];
initial 
	begin
		$readmemh("L_TABLE.txt",rom);
	end		
	
always @(*)
begin  
	out2<=rom[addr2];
	out1<=rom[addr1];
end

endmodule
