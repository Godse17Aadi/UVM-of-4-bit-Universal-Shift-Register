//usr_sequence_item → what to send
//usr_sequence / usr_sequence_reset / usr_sequence_2 → what to generate and when
//usr_sequencer → who passes the generated items to the driver

class usr_sequence extends uvm_sequence#(usr_sequence_item);
	//uvm factory
	`uvm_object_utils(usr_sequence)
	
	//transaction
	usr_sequence_item tx;
	
	int LOOP = 50;
	
	//constructor
	function new(name="usr_sequence");
		super.new(name);
	endfunction
	
	//Task body
	virtual task body();
	   repeat(LOOP) begin
	     tx = sequence_item_dff::type_id::create("tx");
	     start_item(tx);
	     tx.randomize();
	     tx.rst_n=1;
	     finish_item(tx);
	   end
	endtask:body
endclass : usr_sequnce

//-----------------------*** *** ***----------------------
class usr_sequence_reset extends usr_sequence;
	
	`uvm_object_utils(usr_sequence_reset)
	
	//constructor
	function new(name="usr_sequence_reset");
		super.new(name);
	endfunction
	
	//transaction
	usr_sequence_item tx;

	//Task Body
	
	task body();
		tx = sequence_item_dff::type_id::create("tx");
		start_item(tx);
		tx.in=0;
		tx.select=0;
		tx.rst_n=1;
		finish_item(tx);
	endtask:body
endclass : usr_sequence_reset
		
