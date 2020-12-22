`timescale 1ps/1ps
module rxsim();

  reg clk;
	wire [7:0] leds;
	reg rxdata;

	uartrtx_top ut(
		.clk(clk),
		.SW(16'hFF),
		.UART_TXD_IN(rxdata)
	);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

 integer i;  
  initial begin
    $dumpfile("rxsim.vcd");
    $dumpvars(0, rxsim);
//    $monitor ("%t: clk = %b", $time, clk);
  end


  initial begin
		rxdata = 1;
		#300 rxdata = 0;
		#8680 rxdata = 1;
		#8681 rxdata = 0;
		#8680 rxdata = 1;
		#100000 rxdata = 0;
		#8680 rxdata = 1;
    #200000 $finish();
  end

endmodule
