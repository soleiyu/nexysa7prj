module tscaler
(
	input  wire [7:0] 	inpv,   
	output wire [31:0]  	outv
);

	assign outv = tscl(inpv);
	
	function [31: 0] tscl(input [7:0] in);
begin
  case(in)
  8'd1: tscl = 32'd2750;
  8'd2: tscl = 32'd2914;
  8'd3: tscl = 32'd3087;
  8'd4: tscl = 32'd3270;
  8'd5: tscl = 32'd3465;
  8'd6: tscl = 32'd3671;
  8'd7: tscl = 32'd3889;
  8'd8: tscl = 32'd4120;
  8'd9: tscl = 32'd4365;
  8'd10: tscl = 32'd4625;
  8'd11: tscl = 32'd4890;
  8'd12: tscl = 32'd5191; 
  
  8'd13: tscl = 32'd5500;
  8'd14: tscl = 32'd5827;
  8'd15: tscl = 32'd6174;
  8'd16: tscl = 32'd6541;
  8'd17: tscl = 32'd6930;
  8'd18: tscl = 32'd7342;
  8'd19: tscl = 32'd7778;
  8'd20: tscl = 32'd8241;
  8'd21: tscl = 32'd8731;
  8'd22: tscl = 32'd9250;
  8'd23: tscl = 32'd9800;
  8'd24: tscl = 32'd10383; 
  
  8'd25: tscl = 32'd11000;
  8'd26: tscl = 32'd11654;
  8'd27: tscl = 32'd12347;
  8'd28: tscl = 32'd13081;
  8'd29: tscl = 32'd13859;
  8'd30: tscl = 32'd14683;
  8'd31: tscl = 32'd15556;
  8'd32: tscl = 32'd16481;
  8'd33: tscl = 32'd17461;
  8'd34: tscl = 32'd18500;
  8'd35: tscl = 32'd19600;
  8'd36: tscl = 32'd20765; 
  
  8'd37: tscl = 32'd22000;
  8'd38: tscl = 32'd23308;
  8'd39: tscl = 32'd24694;
  8'd40: tscl = 32'd26163;
  8'd41: tscl = 32'd27718;
  8'd42: tscl = 32'd29367;
  8'd43: tscl = 32'd31113;
  8'd44: tscl = 32'd32963;
  8'd45: tscl = 32'd34923;
  8'd46: tscl = 32'd37000;
  8'd47: tscl = 32'd39200;
  8'd48: tscl = 32'd41531;
  8'd49: tscl = 32'd44000;
  
  8'd50: tscl = 32'd46616;
  8'd51: tscl = 32'd49388;
  8'd52: tscl = 32'd52325;
  8'd53: tscl = 32'd55437;
  8'd54: tscl = 32'd58733;
  8'd55: tscl = 32'd62225;
  8'd56: tscl = 32'd65926;
  8'd57: tscl = 32'd69846;
  8'd58: tscl = 32'd73999;
  8'd59: tscl = 32'd78399;
  8'd60: tscl = 32'd83061;  
  8'd61: tscl = 32'd88000;
  
  8'd62: tscl = 32'd93233;
  8'd63: tscl = 32'd98777;
  8'd64: tscl = 32'd104650;
  8'd65: tscl = 32'd110873;
  8'd66: tscl = 32'd117466;
  8'd67: tscl = 32'd124451;
  8'd68: tscl = 32'd131851;
  8'd69: tscl = 32'd139691;
  8'd70: tscl = 32'd147998;
  8'd71: tscl = 32'd156798;
  8'd72: tscl = 32'd166122;  
  8'd73: tscl = 32'd176000;
  
  8'd74: tscl = 32'd186466;
  8'd75: tscl = 32'd197553;
  8'd76: tscl = 32'd209301;
  8'd77: tscl = 32'd221746;
  8'd78: tscl = 32'd234932;
  8'd79: tscl = 32'd248902;
  8'd80: tscl = 32'd263702;
  8'd81: tscl = 32'd279383;
  8'd82: tscl = 32'd295996;
  8'd83: tscl = 32'd313596;
  8'd84: tscl = 32'd332244;  
  8'd85: tscl = 32'd352000;
  
  8'd86: tscl = 32'd372931;
  8'd87: tscl = 32'd395107;
  8'd88: tscl = 32'd418601;
  default : tscl = 1;
  endcase
end
endfunction
	
endmodule