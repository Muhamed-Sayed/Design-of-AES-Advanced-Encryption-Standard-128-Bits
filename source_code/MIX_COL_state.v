module MIX_COL_state(clk,rst,start,data_in,out_mem,flag,data_addr,DONE,ADD_ROUND_start,ADD_ROUND_addr);

input wire clk,rst,start,ADD_ROUND_start;
input wire [7:0] data_in;
input wire [3:0] ADD_ROUND_addr;
output wire [7:0] out_mem;
output wire flag,DONE;
output wire [3:0] data_addr; 

wire [7:0] out1,out2,out_comp,out_gf,out_E,out_REG;
wire [8:0] out_add;
wire [3:0] count_gf,data_addr_reg,mem_addr,mem_addr_reg,mem_addr_reg2,mem_addr_reg3,addr_mux;
wire reg_flag,reg_flag2,clear_sig,clear_sig_reg1,clear_sig_reg2,clear_sig_reg3;

counter_mix_col counter_mix_col(clk,rst,start,count_gf,data_addr,mem_addr,flag,clear_sig);

GALOIS_FIELD GALOIS_FIELD(clk,count_gf,out_gf);

L_TABLE L_TABLE(data_in,out_gf,out1,out2);
adder_2in adder_2in(out1,out2,out_add);
Register #(.size(1))Register_flag(clk,rst,flag,reg_flag);
Register #(.size(1))Register_flag2(clk,rst,reg_flag,reg_flag2);
Register #(.size(1))Register_flag3(clk,rst,reg_flag2,reg_flag3);

comparator_FF comparator_FF(out_add,out_comp);
E_TABLE E_TABLE(clk,out_comp,out_E);


REG_MIX_COL #( .size(8)) REG_MIX_COL (clk,rst,reg_flag2,clear_sig_reg3&&reg_flag3==1||reg_flag2==0,out_E,out_REG);
Register #(.size(4))Register_mem1(clk,rst,mem_addr,mem_addr_reg);
Register #(.size(4))Register_mem2(clk,rst,mem_addr_reg,mem_addr_reg2);
Register #(.size(4))Register_mem3(clk,rst,mem_addr_reg2,mem_addr_reg3);

Register #(.size(1))Register_clear1(clk,rst,clear_sig,clear_sig_reg);
Register #(.size(1))Register_clear2(clk,rst,clear_sig_reg,clear_sig_reg1);
Register #(.size(1))Register_clear3(clk,rst,clear_sig_reg1,clear_sig_reg2);
Register #(.size(1))Register_clear4(clk,rst,clear_sig_reg2,clear_sig_reg3);

MUX2X1 #(.size(4))MUX2X1_inst1 (mem_addr_reg3,ADD_ROUND_addr,ADD_ROUND_start,addr_mux);

MIX_COL_mem  MIX_COL_mem(clk,rst,addr_mux,out_REG,clear_sig_reg3&&reg_flag3==1,out_mem);

assign DONE=mem_addr_reg3==15&&clear_sig_reg3;

endmodule
