module SUB_BYTES_state(clk,rst,start,data_in,addr_in,wr_in,out_mem,SHIFT_flag_reg,count_out_reg,DONE);
input wire clk,rst,start,wr_in,DONE;
input wire [7:0] data_in;
input wire [3:0] addr_in;
output wire [7:0] out_mem;
output wire SHIFT_flag_reg;
output wire [3:0] count_out_reg;
wire [3:0] count_out,count_out_reg2;
reg [3:0] addr_subBytes_mem;
reg [7:0] in_subBytes_mem;
wire [7:0] out_s_box;
wire SUB_flag,SUB_flag_reg1,SUB_flag_reg2,SHIFT_flag;

always @(*)
	begin
		case(wr_in)
			1: begin addr_subBytes_mem=addr_in; in_subBytes_mem=data_in; end
			0: begin addr_subBytes_mem=count_out_reg2; in_subBytes_mem=out_s_box; end
		endcase
	end
	
subBytes_mem subBytes_mem(clk,rst,(wr_in||SUB_flag_reg2||SUB_flag_reg1)&&!DONE,SHIFT_flag||SUB_flag||start,
									addr_subBytes_mem,count_out,in_subBytes_mem,out_mem);

S_BOX S_BOX(clk,out_mem,out_s_box);

counter_SUB_bytes counter_SUB_bytes(clk,rst,start,count_out,SUB_flag,SHIFT_flag);

Register #(.size(4))Register_count1( clk,rst,count_out,count_out_reg);
Register #(.size(4))Register_count2( clk,rst,count_out_reg,count_out_reg2);

Register #(.size(1))Register_flag1( clk,rst,SUB_flag,SUB_flag_reg1);
Register #(.size(1))Register_flag2( clk,rst,SUB_flag_reg1,SUB_flag_reg2);

Register #(.size(1))Register_flag3( clk,rst,SHIFT_flag,SHIFT_flag_reg);

endmodule
