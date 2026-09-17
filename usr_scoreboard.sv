//two different types of analysis implementation ports
/*`uvm_analysis_imp_decl(_X)` is a UVM macro used when a component, such as a scoreboard, needs multiple analysis implementation ports. It creates a specialized `uvm_analysis_imp_X` type whose received transactions are handled by a corresponding `write_X()` function instead of the normal `write()`. For example, `uvm_analysis_imp_decl(_drv)` creates `uvm_analysis_imp_drv` and connects to `write_drv()`, while `_mon` connects to `write_mon()`. This allows the scoreboard to distinguish transactions coming from different sources, such as a driver and monitor.
*/
`uvm_analysis_imp_decl(_drv)
`uvm_analysis_imp_decl(_mon)
class usr_scoreboard extends uvm_scorebaord;

	//uvm factory registration
	`uvm_component_utils(usr_scoreboard)
	uvm_analysis_imp_drv #(usr_sequence_item, scoreboard_dff) aport_drv;
	uvm_analysis_imp_mon #(usr_sequence_item, scoreboard_dff) aport_mon;
	
	
	//TLM FIFO is basically a queue/mailbox inside the scoreboard that stores those transactions until the scoreboard's run_phase() is ready to process them
	uvm_tlm_fifo #(usr_sequence_item) expfifo; //expected fifo
	uvm_tlm_fifo #(usr_sequence_item) outfifo;
	
	int VECTOR_COUNT,PASS_COUNT,ERROR_COUNT;
	
