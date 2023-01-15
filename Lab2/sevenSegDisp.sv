module sevenSegDisp(value, dig5, dig4, dig3, dig2, dig1, dig0 );
	input [19:0] value;
	output [7:0] dig5, dig4, dig3, dig2, dig1, dig0; //5 to 0 are the 6 displays on the board from left to right
	reg [3:0] input1 = 4'd0;
	reg [3:0] input2 = 4'd0;
	reg [3:0] input3 = 4'd0;
	reg [3:0] input4 = 4'd0;
	reg [3:0] input5 = 4'd0;
	
	/* 
	Next, you should write logic to convert the 20 bit value into 6 different 4 bit inputs for each of your displays.
	For example, if your value is 146, you want the three leftmost digits to get 0, dig2 to get input 1, dig1 to get input 4, and dig0 to get input 6.
	You will likely need to use the division and mod operators to convert from binary to base10.

	Please wrap your logic in an always_comb block to ensure combinational logic only.
	----------PART THREE----------
	*/
	
	
	// As the registers are all set to 0, check if the input value is greater than 10^x and do (value/10^x) % 10 to get the remainder if it is
	// Can use loop if input 1-5 are in an array but too lazy.
	// Not sure if you can compare integer with 20 bit bus like this but seems like you can from documents I read online
	
	always_comb begin
		integer i = 1;
		if (i < value) begin
			input5 = (value / i) % 10;
			i = i * 10;
			if (i < value) begin
				input4 = (value / i) % 10;
				i = i * 10;
				if (i < value) begin
					input3 = (value / i) % 10;
					i = i * 10;
					if (i < value) begin
						input2 = (value / i) % 10;
						i = i * 10;
						if (i < value) begin
							input1 = (value / i) % 10;
							i = i * 10;
						end
					end
				end
			end
		end
	end
	
	/* 
	----------PART THREE----------
	Instantiate six of the sevenSegDigit modules that you wrote, one corresponding to each physical display
	*/
	sevenSegDigit digit1(input1, dig1);
	sevenSegDigit digit2(input2, dig2);
	sevenSegDigit digit3(input3, dig3);
	sevenSegDigit digit4(input4, dig4);
	sevenSegDigit digit5(input5, dig5);
endmodule