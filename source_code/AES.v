module AES(clk,rst,start_system,out_ADDROUND,data_in,DONE);

input wire clk,rst,start_system;
input wire [7:0] data_in;
output wire [7:0] out_ADDROUND;
output wire DONE;

wire [3:0] round_num,round_key_addr,round_key_addr_REG,round_key_addr_REG2,round_num_reg,
		   round_num_reg2,round_num_reg3,count_out_SUB_BYTES,MIX_COL_addr,
		   round_key_addr_REG3,round_key_addr_MUX;

wire wr,wr_reg,wr_reg2,SHIFT_flag_reg,Done_SHIFT_ROWS,MIX_COL_start,Done_MIX_COL,start_ADD_ROUND;
wire DONE_temp,DONE_reg1,DONE_reg2,DONE_reg3;
wire [7:0] data_in_reg,out_mem_sub_bytes,out_SHIFT_ROWS,MIX_COL_out,in_add_round,out_mux;

Register #(.size(8))Register_in(clk,rst,data_in,data_in_reg);
Register #(.size(4))Register_round_num(clk,rst,round_num,round_num_reg);
Register #(.size(4))Register_round_num2(clk,rst,round_num_reg,round_num_reg2);
Register #(.size(4))Register_round_num3(clk,rst,round_num_reg2,round_num_reg3);

AES_controller AES_controller (clk,rst,start_system||start_ADD_ROUND,round_num,wr,round_key_addr);

MUX2X1 #(.size(8))MUX2X1_inst2 (out_mux,data_in_reg,round_num_reg2==0,in_add_round);

ADD_ROUND_KEY_state ADD_ROUND_KEY_state (clk,rst,in_add_round,round_key_addr_REG,round_num_reg2,out_ADDROUND);

Register #(.size(4))Register_addr1(clk,rst,round_key_addr,round_key_addr_REG);
Register #(.size(4))Register_addr2(clk,rst,round_key_addr_REG,round_key_addr_REG2);
Register #(.size(4))Register_addr3(clk,rst,round_key_addr_REG2,round_key_addr_REG3);

Register #(.size(1))Register_wr1(clk,rst,wr,wr_reg);
Register #(.size(1))Register_wr2(clk,rst,wr_reg,wr_reg2);
Register #(.size(1))Register_wr3(clk,rst,wr_reg2,wr_reg3);

assign wr_subBytes=(wr_reg2||wr_reg||wr_reg3);
assign round_key_addr_MUX= (round_num_reg3==10) ? round_key_addr_REG3 : round_key_addr_REG2;

SUB_BYTES_state SUB_BYTES_state(clk,rst,round_key_addr_REG2==15,out_ADDROUND,round_key_addr_MUX,
								wr_subBytes,out_mem_sub_bytes,SHIFT_flag_reg,count_out_SUB_BYTES,DONE);
								
SHIFT_ROWS_state SHIFT_ROWS_state(clk,rst,SHIFT_flag_reg,out_mem_sub_bytes,count_out_SUB_BYTES,out_SHIFT_ROWS,
								  Done_SHIFT_ROWS,MIX_COL_start&&round_num_reg!=10,{MIX_COL_addr[1:0],MIX_COL_addr[3:2]},
								  wr&&round_num_reg==10,round_key_addr_REG2);
								  
MIX_COL_state MIX_COL_state(clk,rst,Done_SHIFT_ROWS,out_SHIFT_ROWS,MIX_COL_out,
						MIX_COL_start,MIX_COL_addr,Done_MIX_COL,wr&&round_num_reg!=10,round_key_addr_REG);

assign start_ADD_ROUND=((Done_SHIFT_ROWS&&round_num_reg2==10)||(Done_MIX_COL&&round_num_reg2!=10))&&!DONE;
 
MUX2X1 #(.size(8))MUX2X1_inst1 (MIX_COL_out,out_SHIFT_ROWS,round_num_reg2==10,out_mux);
assign DONE_temp = round_num_reg2==10&&round_key_addr==15;
Register #(.size(1))Register_done1(clk,rst,DONE_temp,DONE_reg);
Register #(.size(1))Register_done2(clk,rst,DONE_reg,DONE_reg2);
Register #(.size(1))Register_done3(clk,rst,DONE_reg2,DONE_reg3);
Register #(.size(1))Register_done4(clk,rst,DONE_reg3,DONE);

endmodule





