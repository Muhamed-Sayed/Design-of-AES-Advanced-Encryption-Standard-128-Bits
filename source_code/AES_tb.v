`timescale 1ns / 1ps


module AES_tb;

	// Inputs
	reg clk;
	reg rst;
	reg start_system;
	reg [7:0] data_in;
	// Outputs
	wire [7:0] out_ADDROUND;
	wire DONE;

	// Instantiate the Unit Under Test (UUT)
	AES uut (
		.clk(clk), 
		.rst(rst), 
		.start_system(start_system), 
		.out_ADDROUND(out_ADDROUND), 
		.data_in(data_in),
		.DONE(DONE)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		start_system = 0;
		data_in = 0;
		#10 rst =1;
      #15   start_system=1;  
		#10   data_in = 8'h32;
		#10   start_system=0;  data_in = 8'h88;
		#10 data_in = 8'h31;
		#10 data_in = 8'he0;
		#10 data_in = 8'h43;
		#10 data_in = 8'h5a;
		#10 data_in = 8'h31;
		#10 data_in = 8'h37;
		#10 data_in = 8'hf6;
		#10 data_in = 8'h30;
		#10 data_in = 8'h98;
		#10 data_in = 8'h07;
		#10 data_in = 8'ha8;
		#10 data_in = 8'h8d;
		#10 data_in = 8'ha2;
		#10 data_in = 8'h34;
	end
      always #5 clk=~clk;
endmodule

