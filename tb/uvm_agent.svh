// Create an intermediate container called "agent" to hold
// driver, monitor and sequencer
class agent extends uvm_agent;
	driver d0;		// Driver handle
	monitor m0;		// Monitor handle
	uvm_sequencer #(Item) s0;		// Sequencer Handle

	`uvm_component_utils(agent)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		s0 = uvm_sequencer #(Item)::type_id::create("s0", this);
		d0 = driver::type_id::create("d0", this);
		m0 = monitor::type_id::create("m0", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		d0.seq_item_port.connect(s0.seq_item_export);
	endfunction

endclass
