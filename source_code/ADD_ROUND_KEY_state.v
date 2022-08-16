module ADD_ROUND_KEY_state(clk,rst,data_in,addr_in,sel,out_REG);
input wire clk,rst;
input wire [7:0] data_in;
input wire [3:0] addr_in;
input wire [3:0] sel;
output wire [7:0] out_REG;

wire [7:0] out;
reg [7:0] out_mux;
wire [7:0] out_round0,out_round1,out_round2,out_round3,out_round4,out_round5,
			  out_round6,out_round7,out_round8,out_round9,out_round10,out_round10_reg;
always @(*)
begin
	case(sel)
		0:  out_mux=out_round0;
		1:  out_mux=out_round1;
		2:  out_mux=out_round2;
		3:  out_mux=out_round3;
		4:  out_mux=out_round4;
		5:  out_mux=out_round5;
		6:  out_mux=out_round6;
		7:  out_mux=out_round7;
		8:  out_mux=out_round8;
		9:  out_mux=out_round9;
		10: out_mux=out_round10_reg;
	default:out_mux=0;
	endcase	
end

round_rom #(.FILENAME("Round_Keys/Cipher_key.txt")) round_0	(clk,addr_in,out_round0);
round_rom #(.FILENAME("Round_Keys/round1_key.txt")) round_1	(clk,addr_in,out_round1);
round_rom #(.FILENAME("Round_Keys/round2_key.txt")) round_2	(clk,addr_in,out_round2);
round_rom #(.FILENAME("Round_Keys/round3_key.txt")) round_3	(clk,addr_in,out_round3);
round_rom #(.FILENAME("Round_Keys/round4_key.txt")) round_4	(clk,addr_in,out_round4);
round_rom #(.FILENAME("Round_Keys/round5_key.txt")) round_5	(clk,addr_in,out_round5);
round_rom #(.FILENAME("Round_Keys/round6_key.txt")) round_6	(clk,addr_in,out_round6);
round_rom #(.FILENAME("Round_Keys/round7_key.txt")) round_7	(clk,addr_in,out_round7);
round_rom #(.FILENAME("Round_Keys/round8_key.txt")) round_8	(clk,addr_in,out_round8);
round_rom #(.FILENAME("Round_Keys/round9_key.txt")) round_9	(clk,addr_in,out_round9);
round_rom #(.FILENAME("Round_Keys/round10_key.txt")) round_10	(clk,addr_in,out_round10);

Register #(.size(8))Register1( clk,rst,out_round10,out_round10_reg);

assign out_REG = out_mux ^ data_in;
//Register #(.size(8))Register_mem3(clk,rst,out,out_REG);

endmodule
