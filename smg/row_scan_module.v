module row_scan_module (
	input CLK,
	input [7:0]Ten_SMG_Data0,
	input [7:0]One_SMG_Data0,
	input [7:0]Ten_SMG_Data1,
	input [7:0]One_SMG_Data1,
	input [7:0]Ten_SMG_Data2,
	input [7:0]One_SMG_Data2,
	output [7:0]Row_Scan_Sig
);

/*******************************/

parameter T10MS = 6'd54;//50M*0.01-1=499_999

/*******************************/

reg [5:0]Count1;

always @ ( posedge CLK )
	if( Count1 == T10MS )
		Count1 <= 6'd0;
	else
		Count1 <= Count1 + 1'b1;

/*******************************/

reg [2:0]t;

always @ ( posedge CLK )
	if( t == 3'd6 )
		t <= 3'd0;
	else if( Count1 == T10MS )
		t <= t + 1'b1;

/**********************************/

reg [7:0]rData;

always @ ( posedge CLK )
	if( Count1 == T10MS )
		case( t )
			3'd0 : rData <= Ten_SMG_Data0;
			3'd1 : rData <= One_SMG_Data0;
			3'd2 : rData <= Ten_SMG_Data1;
			3'd3 : rData <= One_SMG_Data1;
			3'd4 : rData <= Ten_SMG_Data2;
			3'd5 : rData <= One_SMG_Data2;
		endcase

/***********************************/

assign Row_Scan_Sig = rData;

/***********************************/

endmodule
