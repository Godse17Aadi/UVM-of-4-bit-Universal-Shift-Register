class usr_agent extends uvm_agent;
	//uvm factory
	`uvm_component_utils(usr_agent)
	
	//analysis port
	uvm_analysis_port#(usr_sequence_item) agent_ap_mon;
	//constructor
	function new(string name="usr_agent", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	//handles
	usr_driver usr_drv;
	usr_monitor usr_mon;
	usr_sequencer usr_seq;
	
	//build 
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent_ap_mon = new("agent_ap_mon", this);
 
		usr_seq = sequencer_dff::type_id::create("usr_seq", this);
		usr_drv = driver_dff::type_id::create("usr_drv", this);
		usr_mon = monitor_dff::type_id::create("usr_mon", this);
	endfunction
	
	//connect
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		//connect sequencer to your driver
		usr_drv.seq_item_port.connect(usr_seq.seq_item_export);
	endfunction
endclass:usr_agent
		
		
//The monitor doesn't connect to the sequencer or driver.
/*So the environment's connect_phase connects:

Monitor ──────► Scoreboard*/
/*the monitor is still instantiated inside the agent. It just doesn't participate in the sequencer-driver connection. Its output is connected upward to the scoreboard by the environment.*/
