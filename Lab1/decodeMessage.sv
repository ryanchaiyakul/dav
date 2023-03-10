`timescale 1 ns / 1 ns //This line tells the simulator what time scale to use with simulation delays.
							  //Feel free to ignore this for now.

module decodeMessage(encodedText, decodedText);
	input [191:0] encodedText; //this is our input
	output [191:0] decodedText; //this is our output wire!
	wire [191:0] stage1Out; //this is a wire we will use to connect our two stages
    

	/*
	NOTE: ------------------------------------------------------------------------------------------------------
		Comments in Verilog work similarly to C++, denoted with the slash and asterisk. 
		You can have single line comments too -- use "//" before anything you want to comment out
	------------------------------------------------------------------------------------------------------------
	*/

	partOne UUT1(.in(encodedText), .out(stage1Out)); //.in(encodedText) means connect the `encodedText` wire to the port in partOne called `in`
	partTwo UUT2(.in(stage1Out), .out(decodedText));
	//TODO: The first module (partOne) is already instantiated, but we still need to instantiate the partTwo message here as well.
	
endmodule

 
 
 
module partOne(in, out);
	input [191:0] in; //this is the input port, which is 192 bits wide.
	output [191:0] out; //this is the output port.
	
	/*
	TODO: ------------------------------------------------------------------------------------------------------
		Step 1: you are given a 8 bit key (binary value 01101110) that you should assign to a wire.
		
				Hint: If you want to tell Verilog to store a number in binary with 4 bits, you would say
						assign myValue = 4'b0101; 
						where b is for binary and 4 is # of bits.

		Step 2: To decode our 192-bit line, we need to extend our key to that length by repeating it several times.
				  192 bits is 24 bytes, so you will need to replicate the given key 24 times.
				  
				Hint: If I wanted to copy a value `oldSignal` four times into a new bus, I would write:
						assign myNewSignal = {4{oldSignal}};

		Step 3: Now, XOR your input with this 192 bit key. The output of this should be the output of the partOne module.
	------------------------------------------------------------------------------------------------------------
	*/
	
	// Step 1
	
	wire [7:0] key;
	assign key = 8'b01101110;
	
	// Step 2
	
	wire [191:0] fullKey;
	assign fullKey = {24{key}};
	
	// Step 3
	
	assign out = in^fullKey;
	
	
endmodule
 

/*
TODO: -------------------------------------------------------------------------------------------------------
	Step 1: Declare a module partTwo with an input and output port of the correct size. 

	Step 2: Declare any internal wires for intermediate steps before any of the logic.

	Step 3: Flip all the bits of your input.

	Step 4: Add the literal decimal value 192'd138927 to your input.

	Step 5: Reorder the signal from the order ABC to CAB. (A includes the MSB)
			  Since 192 bits is divisible into 3 parts of equal length, this should be easy!
			
			Hint: Use bit/array indexing and the {} operator to join wires into a bus.
	
	And remember to close your module!
------------------------------------------------------------------------------------------------------------
*/

module partTwo(in, out);
	input [191:0] in;
	output [191:0] out;
	
	// Step 3
	
	wire [191:0] flipped;
	
	assign flipped = ~in;
	
	//Step 4
	
	wire [191:0] added;
	
	assign added = flipped + 192'd138927;
	
	// Step 5
	
	assign {out} = {added[63:0], added[191:128], added[127:64]};
	
endmodule
	
	