module uni_shift_reg(
	input clk,
	input rst_n,
	input [3:0] in, //in[3] - serial input right ******--****** in[0] - serial input shift left
	input [1:0] select,
	output [3:0] out
	);
	always@(posedge clk) begin
		if(!rst_n) out <= 4'b0000;
		else begin
			case(select)
				2'h1:out<= { in[3], out[3:1]}; //Right shift
				2'h2:out<= {out[2:0], in[0]}; //left shift
				2'h3:out<=in; //parallel in -out
				default:out<=out; //no change
			endcase
		end
	end
endmodule

/* 
00 -> No Change
01 -> SHift Right
10 -> Shift Left
11 -> Parallel Load
	
