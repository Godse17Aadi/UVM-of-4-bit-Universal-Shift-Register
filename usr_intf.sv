interface usr_intf;
	logic clk=0;
	logic rst_n;
	logic [3:0] in;
	logic [1:0] select;
	logic [3:0] out;
	
	clocking cb @(posedge clk);
                default input #1 output #2;
                output rst_n, in, select;
                input out;
        endclocking
endinterface:use_intf



//----------------------------*** *** ***--------------------

/* Need of Clocking Block:

Eliminates Race Conditions: In simulations, if the testbench changes a signal at the exact same simulation timestep as the clock edge, it creates non-deterministic behavior (races). A clocking block prevents this by defining explicit timing "skews"

Input Skew (Sampling): Tells the testbench to sample inputs slightly before the clock edge (by default, in the Preponed region of the simulation timeline). This ensures the monitor always reads stable, settled data

Output Skew (Driving): Tells the testbench to drive outputs slightly after the clock edge, mimicking real hardware setup/hold characteristics and preventing the DUT from seeing data prematurely

Directional Context (Testbench-Centric): Inside a clocking block, input and output directions are defined from the testbench's perspective. For example, a DUT output is marked as an input in the clocking block because the testbench needs to read it.

Cycle Delay Operator (##): Allows UVM components to easily stall operations in terms of clock cycles (e.g., ##2; waits exactly 2 clock cycles relative to the block's clock)
 
*/

