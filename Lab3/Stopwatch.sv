module Stopwatch(clk1, clk2, reset, startstop, counter, leds, switch);
    input clk1;
	 input clk2;
    input reset;
    input startstop;
	 input switch;
    output reg [18:0] counter;
    output [3:0] leds;
    
    reg [1:0] state;
    reg [1:0] nextstate;
	 reg clk;
    
    parameter RESET = 2'd0;
    parameter RUN = 2'd1;
    parameter PAUSE = 2'd2;
	 
	 always_comb begin
		if (switch == 0)
				clk = clk1;
		else	clk = clk2;
		
	 end
    
    always @(negedge startstop or negedge reset) begin
        if (~reset) begin
            nextstate = RESET;
        end
        else begin
            if (state == RESET) begin
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

    // state machine
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            state <= RESET;
            counter <= 19'd0;
        end
        else begin
            state <= nextstate;
            if (state == RUN) begin
                counter <= counter + 1;
            end
        end
    end
        
endmodule