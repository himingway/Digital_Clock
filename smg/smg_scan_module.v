module smg_scan_module (
	input CLK,
	input [7:0]Ten_SMG_Data0,
	input [7:0]One_SMG_Data0,
	input [7:0]Ten_SMG_Data1,
	input [7:0]One_SMG_Data1,
	input [7:0]Ten_SMG_Data2,
	input [7:0]One_SMG_Data2,
	output [7:0]Row_Scan_Sig,
	output [5:0]Column_Scan_Sig
);

/*****************************/

row_scan_module U1
(
	.CLK( CLK ),
	.Ten_SMG_Data0( Ten_SMG_Data0), // input - from top
	.One_SMG_Data0( One_SMG_Data0), // input - from top
	.Ten_SMG_Data1( Ten_SMG_Data1), // input - from top
	.One_SMG_Data1( One_SMG_Data1), // input - from top
	.Ten_SMG_Data2( Ten_SMG_Data2), // input - from top
	.One_SMG_Data2( One_SMG_Data2), // input - from top
	.Row_Scan_Sig ( Row_Scan_Sig )  // output - to top
);

column_scan_module U2
(
	.CLK( CLK ),
	.Column_Scan_Sig( Column_Scan_Sig ) // output - to top
);

/********************************/

endmodule
