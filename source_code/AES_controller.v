module AES_controller(clk,rst,start,round_num,wr,round_key_addr);
input wire clk,rst,start;
output reg [3:0] round_num;
output wire [3:0] round_key_addr;
output reg wr;
reg [3:0] round_key_addr_temp;
reg flag;

always @(posedge clk or negedge rst)
begin
	if(!rst)
		begin 
			round_num<=0; round_key_addr_temp<=0; wr<=0; flag<=0;
		end
	else 
		begin
			if(round_num==10&&round_key_addr_temp==15); 
			else if (round_key_addr_temp==15) 
				begin 
					flag<=0;	wr<=0; round_num<=round_num+4'b1; round_key_addr_temp<=0;
				end
			else if (start||flag)
				begin
					flag<=1;
					round_key_addr_temp<=round_key_addr_temp+4'b1;
					wr<=1;
				end
		end
end
assign round_key_addr=round_key_addr_temp;


endmodule
