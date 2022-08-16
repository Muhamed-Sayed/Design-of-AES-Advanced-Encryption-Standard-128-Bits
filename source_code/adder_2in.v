module adder_2in(in1,in2,out);
input wire [7:0] in1,in2;
output wire [8:0] out;

assign out = in1 + in2;

endmodule
