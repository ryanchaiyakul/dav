module Timer(clk, clk2, reset, startstop, counter, switches, led, buzzer, display_on);
	input clk;
	input clk2;
	input reset;
	input startstop;
	input [9:0] switches;
	output reg[18:0] counter;
	output led;
	output buzzer;
	output display_on;
	
	reg buzzerEnable;
	reg counter_zero;
	
	assign buzzer = clk2 & buzzerEnable;

	reg [1:0] state, nextstate;
	reg [4:0] flash_counter;

	// States
	parameter SET = 2'b00;
	parameter RUN = 2'b01;
	parameter PAUSE = 2'b10;
	parameter BEEP = 2'b11;
	
	always @ (negedge startstop, negedge reset, posedge counter_zero) begin
		if (~reset) begin
            nextstate = SET;
        end
        else begin
				if (counter_zero) begin
					if (state == RUN || state == BEEP) begin
						nextstate = BEEP;
					end
					else begin
						nextstate = SET;
					end
				end
				else begin
					if (state == SET) begin
						 nextstate = RUN;
					end
					else if (state == RUN) begin
						 nextstate = PAUSE;
					end
					else if (state == PAUSE) begin
						 nextstate = RUN;
					end
				end
        end
	end
	
	always @ (counter) begin
		if (counter == 0)
				counter_zero = 1;
		else 	counter_zero = 0;
	end

	always@(posedge clk, negedge reset) begin
	  if (!reset) begin
            state <= SET;
	  end
	  else begin
		state <= nextstate;
		if (state == SET) begin
			counter = 100*(switches[0] + switches[1] + switches[2] + switches[3] + switches[4] + switches[5] + switches[6] + switches[7] + switches[8] + switches[9]);
		end
		if (state == RUN) begin
			if (counter != 0)
				counter = counter - 1;
		end
		if (state == BEEP) begin
				buzzerEnable = 1;
				led = 1;
				if (flash_counter == 10) begin
					display_on = ~display_on;
					flash_counter = 0;
				end
				else	flash_counter = flash_counter + 1;
			end
		else begin
			flash_counter = 0;
			buzzerEnable = 0;
			led = 0;
			display_on = 1;
		end
	  end
	end
	
endmodule