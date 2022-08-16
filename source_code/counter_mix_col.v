module counter_mix_col(clk,rst,start,count_gf,data_addr,mem_addr,flag,clear_sig);
input wire clk,rst,start;
output reg [3:0] count_gf;
output reg [3:0] data_addr;
output wire [3:0] mem_addr;
output reg flag;
output wire clear_sig;
reg [1:0] count_data,round_gf;
reg [3:0] mem_addr_inv;
always @(posedge clk or negedge rst)
begin
	if(!rst)
		begin
			count_gf<=4'd15; count_data<=2'd3; round_gf<=2'd3; flag<=1'b0; mem_addr_inv<=4'd15;
		end
	else 
		begin
			if (count_gf==15&&round_gf==3&&flag==1)	
				begin
					flag<=1'b0; 
				end
			else if (start || flag)	
				begin
					count_gf<=count_gf+4'b1; flag<=1'b1; count_data<=count_data+2'b1;
					if(count_gf==4'b1111)
						round_gf<=round_gf+2'b1;
					if (count_data==3)
						mem_addr_inv<=mem_addr_inv+4'b1;
				end
		end
end	

always @(*)
	begin
		case(round_gf)
		2'b0: data_addr=count_data;
		2'b01:data_addr=count_data+4'b0100;
		2'b10:data_addr=count_data+4'b1000;
		2'b11:data_addr=count_data+4'b1100;
		endcase
	end
	
assign clear_sig= (count_data==2) ? 1'b1 : 1'b0;
assign mem_addr={mem_addr_inv[1:0],mem_addr_inv[3:2]};

endmodule
