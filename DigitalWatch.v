module DigitalWatch (
	input clk,    // Clock
	input wire Button0_IN,
	input wire Button1_IN,
	input wire Button2_IN,
	input wire Button3_IN,
	
	output wire [7:0]Row_Scan_Sig,
	output wire [5:0]Column_Scan_Sig,
	output [3:0] Week
);

	wire [7:0] SecBuffer;
	wire [7:0] MinBuffer;
	wire [7:0] HrBuffer;
	wire [1:0] Blink;
	wire clk_32_768K;
	
pll PLL0 (clk,clk_32_768K);

Watch_Control W0 (
	.clk_32_768K(clk_32_768K),
	.Button0_IN (Button0_IN),
	.Button1_IN (Button1_IN),
	.Button2_IN (Button2_IN),
	.Button3_IN (Button3_IN),
	.Blink      (Blink),
	.SecBuffer  (SecBuffer),
	.MinBuffer  (MinBuffer),
	.HrBuffer   (HrBuffer),
	.Week       (Week)
);
smg smg0 (
	.CLK            (clk_32_768K),
	.Blink          (Blink),
	.Number_Data    ({HrBuffer,MinBuffer,SecBuffer}),
	.Row_Scan_Sig   (Row_Scan_Sig),
	.Column_Scan_Sig(Column_Scan_Sig)
);
endmodule