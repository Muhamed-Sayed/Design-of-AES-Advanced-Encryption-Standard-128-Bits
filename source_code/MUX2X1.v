module MUX2X1 #(parameter size = 8)(in0,in1,sel,out);
input wire [size-1:0] in0,in1;
input wire sel;
output reg [size-1:0] out;


always @(*)
	begin
		case(sel)
			0:out=in0;
			1:out=in1;
		endcase
	end

endmodule
