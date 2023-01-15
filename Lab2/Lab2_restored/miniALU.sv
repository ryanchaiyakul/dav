module miniALU(addend1, addend2, operation, out);
	// Declare inputs/outputs
	input [3:0] addend1, addend2;
	input operation;
	output reg [19:0] out;
	
	// Not sure if this is possible. To be honest very confused on how to add arrays from bits to each other or integers etc. so you probably need to fix all of the operations
	always_comb begin
	if (operation == 1'b0)
		out = addend1 + addend2;
	else
		out = addend1 << addend2;
	end
	
endmodule