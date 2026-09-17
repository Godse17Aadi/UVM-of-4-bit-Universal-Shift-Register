`include "usr_intf.sv" 
`include "tb_pkg.sv"

module top;
	//import package
	import uvm_pkg::
	import tb_pkg::
	
	//interface
	usr_intf vif();
	
	//connecting interface and dut
	uni_shit_reg(
		.clk(vif.clk),
		.rst_n(vif.rst_n),
		.in(vif.in),
		.select(vif.select),
		.out(vif.out)
		);
		
	//uvm configuration
	initial begin
		uvm_config_db#(virtual usr_intf)::set(uvm_root::get(),"","vif",vif);
		run_test("usr_test");
	end
	
	always
		#5 vif.clk = ~vif.clk;
endmodule
 

