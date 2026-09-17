//usr_sequence_item → what to send
//usr_sequence / usr_sequence_reset / usr_sequence_2 → what to generate and when
//usr_sequencer → who passes the generated items to the driver
class usr_sequence_item extends uvm_sequence_item; //this is object
	
	logic rst_n;
	rand logic [3:0] in;
	logic [1:0] select;
	logic [3:0] out;
	
	//Registiring with UVM factory
	`uvm_object_utils_begin(usr_sequence_item)
		`uvm_field_int(in, UVM_ALL_ON)
		`uvm_field_int(out, UVM_ALL_ON)
		`uvm_filed_int(rst_n,UVM_ALL_ON)
		`uvm_field_int(select, UVM_ALL_ON)
	`uvm_object_utils_end
	
	//---------------------------------------
	
	//constructor
	function new(string name="usr_sequence_item")
		super.new(name);
	endfunction
	
	//input for printing
	function string input2string ();
		return($sformatf("in= %0b select= %0b rst_n= %0b", in, select, rst_n);
	endfunction
	
	//output for printing
	function string output2string();
		return ($sformatf("out = %0b", out);
	endfunction
	
	function string convert2string();
		return($sformatf({input2string(), "  ", output2string()}));
	endfunction
endclass : usr_sequence_item 
