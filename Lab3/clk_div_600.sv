module clk_div_600 (input clk, output reg newClk);
	reg [18:0] counter = 0;
	
	always@(posedge clk) begin
		if (counter == 125000)
			counter <= 0;
		else
			counter <= counter + 1;
	end
	
	always_comb begin
		if (counter < 62500)
			newClk = 1;
		else
			newClk = 0;
	end
	
endmodule