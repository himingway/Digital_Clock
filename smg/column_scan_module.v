module column_scan_module (
	input CLK,
	output [5:0]Column_Scan_Sig
);

/*****************************/

parameter T10MS = 6'd54;

/*****************************/

reg [5:0]Count1;

always @ ( posedge CLK )
	if( Count1 == T10MS )
		Count1 <= 5'd0;
	else
		Count1 <= Count1 + 1'b1;

/*******************************/

reg [2:0]t;

always @ ( posedge CLK )
	if( t == 3'd6 )
		t <= 3'd0;
	else if( Count1 == T10MS )
		t <= t + 1'b1;

/*********************************/

reg [5:0]rColumn_Scan;

always @ ( posedge CLK )
	if( Count1 == T10MS )
		case( t )
			3'd0 : rColumn_Scan <= 6'b111110;
			3'd1 : rColumn_Scan <= 6'b111101;
			3'd2 : rColumn_Scan <= 6'b111011;
			3'd3 : rColumn_Scan <= 6'b110111;
			3'd4 : rColumn_Scan <= 6'b101111;
			3'd5 : rColumn_Scan <= 6'b011111;
		endcase

/******************************/

assign Column_Scan_Sig = rColumn_Scan;

/******************************/


endmodule
