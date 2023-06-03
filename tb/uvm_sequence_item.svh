// This is the base transaction object that will be used
// in the environment to initiate new transactions and
// capture transactions at DUT interface
class Item extends uvm_sequence_item;
	rand bit in;
	bit out;

	`uvm_object_utils(Item)

	function new(string name = "Item");
		super.new(name);
	endfunction

	constraint c1 {
		in dist {0:/20, 1:/80};
	}

	function string convert2str();
		return $sformatf("in=%0d, out=%0d", in, out);
	endfunction
endclass
