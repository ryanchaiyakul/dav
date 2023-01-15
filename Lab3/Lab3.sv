module Lab3(switches, leds, reset, startstop, dig0, dig1, dig2, dig3, dig4, dig5, clock, buzzer);
    input [9:0] switches; // Declare the switches as inputs
	 output [9:0] leds;
    output [7:0] dig0, dig1, dig2, dig3, dig4, dig5; // Set the digits of the seven seg disp
    input reset; 
    input startstop; // set the reset and start buttons
	 input clock;
	 output buzzer;
	 
	 reg [18:0] counter;
	 
	 reg clk1;
	 reg clk2;
	 reg clk3;
	 
	 clk_div_100 clk_div1 (clock, clk1);
	 clk_div_200 clk_div2 (clock, clk2);
	 clk_div_600 clk_div3 (clock, clk3);
	 
	 assign leds[0] = reset;
	 assign leds[1] = startstop;
	 assign leds[2] = switches[0];
	 
	 reg display_on;
	 
	 //Stopwatch w1(clk1, clk2, reset, startstop, counter, leds[9:6], switches[0]);
	 Timer(clk1, clk3, reset, startstop, counter, switches, leds[9], buzzer, display_on);
	 sevenSegDisp d1(counter, dig0, dig1, dig2, dig3, dig4, dig5, display_on);
endmodule