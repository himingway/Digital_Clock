module smg
(
	input CLK,
	input [1:0] Blink,
	input [23:0]Number_Data,
	output [7:0]Row_Scan_Sig,
	output [5:0]Column_Scan_Sig
);

/**************************************/
wire [3:0]Ten_Data0;
wire [3:0]One_Data0;
wire [3:0]Ten_Data1;
wire [3:0]One_Data1;
wire [3:0]Ten_Data2;
wire [3:0]One_Data2;
wire [7:0] cRow_Scan_Sig;


number_mod_module U1
(
	.CLK( CLK ),
	.Number_Data(Number_Data), // input - form top
	.Ten_Data0(Ten_Data0), // output - to U2
	.One_Data0(One_Data0), // output - to u2\\U2
	.Ten_Data1(Ten_Data1), // output - to U2
	.One_Data1(One_Data1), // output - to u2\\U2
	.Ten_Data2(Ten_Data2), // output - to U2
	.One_Data2(One_Data2)  // output - to u2\\U2
);

/****************************************/

wire [7:0]Ten_SMG_Data0;
wire [7:0]One_SMG_Data0;
wire [7:0]Ten_SMG_Data1;
wire [7:0]One_SMG_Data1;
wire [7:0]Ten_SMG_Data2;
wire [7:0]One_SMG_Data2;

smg_encoder_module e0
(
	.CLK( CLK ),
	.Ten_Data( Ten_Data0), // input - from U1
	.One_Data( One_Data0), // input - from U1
	.Ten_SMG_Data( Ten_SMG_Data0), // output - to U3
	.One_SMG_Data( One_SMG_Data0)  // output - to U3
);


smg_encoder_module e1
(
	.CLK( CLK ),
	.Ten_Data( Ten_Data1), // input - from U1
	.One_Data( One_Data1), // input - from U1
	.Ten_SMG_Data( Ten_SMG_Data1), // output - to U3
	.One_SMG_Data( One_SMG_Data1)  // output - to U3
);

smg_encoder_module e2
(
	.CLK( CLK ),
	.Ten_Data( Ten_Data2), // input - from U1
	.One_Data( One_Data2), // input - from U1
	.Ten_SMG_Data( Ten_SMG_Data2), // output - to U3
	.One_SMG_Data( One_SMG_Data2)  // output - to U3
);
/*****************************************/

smg_scan_module U3
(
	.CLK( CLK ),
	.Ten_SMG_Data0( Ten_SMG_Data0), // input - from U2
	.One_SMG_Data0( One_SMG_Data0), // input - from U2
	.Ten_SMG_Data1( Ten_SMG_Data1), // input - from U2
	.One_SMG_Data1( One_SMG_Data1), // input - from U2
	.Ten_SMG_Data2( Ten_SMG_Data2), // input - from U2
	.One_SMG_Data2( One_SMG_Data2), // input - from U2
	.Row_Scan_Sig( cRow_Scan_Sig), // output - to top
	.Column_Scan_Sig(Column_Scan_Sig) // output - to top
);


parameter T500MS = 14'd10800;//50M*0.01-1=499_999
reg [13:0]Count1;
reg rblink;
always @(posedge CLK) begin
	if(Blink) begin
		if( Count1 == T500MS ) begin
			Count1 <= 14'd0;
			rblink <= ~rblink;
		end
		else
			Count1 <= Count1 + 1'b1;
	end
end

reg [7:0] rRow_Scan_Sig;
always @(*) begin
	case (Blink)
		2'b01 : rRow_Scan_Sig = (rblink&&(~(Column_Scan_Sig[1]
	&&Column_Scan_Sig[0])))?8'b1111_1111:cRow_Scan_Sig;
		2'b10 : rRow_Scan_Sig = (rblink&&(~(Column_Scan_Sig[3]
	&&Column_Scan_Sig[2])))?8'b1111_1111:cRow_Scan_Sig;
		2'b11 : rRow_Scan_Sig = (rblink&&(~(Column_Scan_Sig[5]
	&&Column_Scan_Sig[4])))?8'b1111_1111:cRow_Scan_Sig;
		2'b00 : rRow_Scan_Sig = cRow_Scan_Sig;
	endcase
end
assign Row_Scan_Sig = rRow_Scan_Sig;
/******************************************/
endmodule
