class usr_monitor extends uvm_monitor;
	
	//uvm factory
	`uvm_component_utils(usr_monitor)
	
	//constructor
	function new(string name="usr_monitor", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	//interface
		virtual interface usr_intf vif;
 
	uvm_analysis_port #(usr_sequence_item) ap_mon; //analysis port
	
	//build
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!(uvm_config_db#(virtual intf_dff)::get(this,"","vif",vif)))
			begin
			`uvm_fatal("monitor","unable to get interface")
			end
		ap_mon=new("ap_mon", this);
		tx=usr_sequence_item::type_id::create("tx",this);
	endfunction
	
	//run
	task run_phase(uvm_phase phase);
		usr_sequence_item tx;
		forever begin
			sample_dut(tx);
			ap_mon.write(tx);
		end
	endtask
	
//-----------------------------------------------------------------------------------------------	

//-----------------------------------------------------------------------------------------------	

	task sample_dut(usr_sequence_item tx);
		t=usr_sequence_item::type_id::create("t",this);
		
		
		t.in=vif.in;
		t.rst_n=vif.rst_n;
		@(vif.cb);
		if(vif.rst_n) t.rst_n=0;
		t.out=vif.cb.out;
		tx=t;
	endtask
endclass:usr_monitor
