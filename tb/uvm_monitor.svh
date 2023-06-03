// The monitor has a virtual interface handle with which
// it can monitor the events happening on the interface.
// It sees new transactions and then captures information
// into a packet and sends it to the scoreboard
// using another mailbox.
class monitor extends uvm_monitor;
	uvm_analysis_port #(Item) mon_analysis_port;
	virtual des_if vif;

	`uvm_component_utils(monitor)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
			 `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
		mon_analysis_port = new ("mon_analysis_port", this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		// This task monitors the interface for a complete 
		// transaction and writes into analysis port when complete
		forever begin
			@ (vif.cb);
			if (vif.rstn) begin
				Item item = Item::type_id::create("item");
				item.in = vif.in;
				item.out = vif.cb.out;
				mon_analysis_port.write(item);
				`uvm_info("MON", $sformatf("Saw item %s", item.convert2str()), UVM_HIGH)
			end
		end
	endtask
endclass
