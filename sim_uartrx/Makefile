default:
	iverilog -o res.out float_add.sv fpsim.v
	./res.out
view:
	gtkwave fpsim.vcd 

rxsim: 
	iverilog -o res.out uartrtx_top.sv rxsim.v
	./res.out
#	gtkwave rxsim.vcd 

