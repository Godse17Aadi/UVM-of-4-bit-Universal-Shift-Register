//Sequencer is a component

class usr_sequencer extends uvm_sequencer#(usr_sequence_item);
	//uvm factory
	`uvm_component_utils(usr_sequencer)
	
	//constructor 
	function new(string name="usr_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction
 
endclass:usr_sequencer

/*
OBJECTS
────────
transaction
sequence


COMPONENTS
──────────
test
env
agent
driver
monitor
sequencer
scoreboard
*/
 
