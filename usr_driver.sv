class usr_drive extends uvm_driver#(usr_sequence_item);
	
	//uvm factory
	`uvm_component_utils(usr_drive)


//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------	
	//analysis port : not a component, more like an object
	//uvm_analysis_port is not a macro. It's a class provided by UVM
	/*The backtick ` is used for preprocessor macros, such as:
	`uvm_component_utils(my_driver)
	`uvm_object_utils(my_transaction)
	`uvm_info("DRV", "Driving transaction", UVM_MEDIUM)
*/
/* What is a preprocessor?
Before SystemVerilog is actually compiled, a preprocessor goes through your source code and handles special instructions.
One of the things it handles is macros.

The backtick ` tells the preprocessor:
"This is a preprocessor directive/macro."

Backtick ` → "preprocessor, do something with this text"

No backtick → normal SystemVerilog language constructor
*/
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------	
	
	uvm_analysis_port #(usr_sequence_item) drv2sb;
	
	//interfac
 
	virtual interface usr_intf vif;
	
	//constructor
	function new(string name ="usr_driver", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	//build
	function build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!(uvm_config_db#(virtual intf_dff)::get(this,"","vif",vif)))begin
			`uvm_fatal("driver","unable to get interface");
		end
		drv2sb=new("drv2sb", this); //driver to scoreboard
	endfunction

	//run
	task run_phase(uvm_phase phase);
		usr_sequence_item tx;
		
		//initialize
		initialize();
		
		forever begin
			seq_item_port.get_next_item(tx);
			drive_item(tx);
			drv2sb.write(tx);
			seq_item_port.item_done();
		end
	endtask
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------	
	
	task initialize();
		vif.in=0;
		vif.rst_n=1;//reset OFF
	endtask
	
	task drive_item(usr_sequence_item tx);
		@(vif.cb); //wait till clockblock's clocking event occurs
		vit.cb.rst_n <= tx.rst_n;
		vif.cb.select <= tx.select;
		vif.cb.in <= tx.in;
	endtask
endclass:usr_driver
		
 
